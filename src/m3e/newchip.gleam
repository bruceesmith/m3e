//// chip provides Lustre support for the [M3E Chip components](https://matraic.github.io/m3e/#/components/chips.html)

import gleam/list.{append, flatten}
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}
import m3e/form_submission.{type FormSubmission}
import m3e/icon.{type Icon}

// --- TYPES ---

pub type Behaviour {
  Normal
  Reset
  Submit
}

pub type Type {
  Assist
  Filter
  Information
  Input
  Suggestion
}

pub type Variant {
  Elevated
  Outlined
}

pub const default_variant: Variant = Outlined

// --- CONFIGURATION ---

/// ChipConfig is a transparent record used for bulk configuration.
pub type ChipConfig {
  ChipConfig(
    label: String,
    type_: Type,
    behaviour: Behaviour,
    disabled: Bool,
    form_submission: Option(FormSubmission),
    icon: Option(Icon),
    removable: Bool,
    selected: Bool,
    variant: Variant,
  )
}

/// Provides a starting point for configuration with sensible defaults.
pub fn default_config(label: String) -> ChipConfig {
  ChipConfig(
    label: label,
    type_: Information,
    behaviour: Normal,
    disabled: False,
    form_submission: None,
    icon: None,
    removable: False,
    selected: False,
    variant: default_variant,
  )
}

/// Chip is the basis for a m3e-chip element.
pub opaque type Chip {
  Chip(
    label: String,
    behaviour: Behaviour,
    disabled: Bool,
    form_submission: Option(FormSubmission),
    icon: Option(Icon),
    removable: Bool,
    selected: Bool,
    type_: Type,
    variant: Variant,
  )
}

// --- VALIDATION HELPERS ---

fn can_have_behaviour(t: Type) -> Bool {
  case t {
    Assist | Suggestion -> True
    _ -> False
  }
}

fn can_be_disabled(t: Type) -> Bool {
  case t {
    Assist | Filter | Suggestion -> True
    _ -> False
  }
}

fn can_be_selected(t: Type) -> Bool {
  case t {
    Filter -> True
    _ -> False
  }
}

// --- CONSTRUCTORS ---

/// Bridges the transparent Config to the Opaque type using shared validation logic.
pub fn from_config(config: ChipConfig) -> Chip {
  Chip(
    label: config.label,
    type_: config.type_,
    variant: config.variant,
    form_submission: config.form_submission,
    icon: config.icon,
    removable: config.removable,
    // Apply validation rules to ensure valid state
    behaviour: case can_have_behaviour(config.type_) {
      True -> config.behaviour
      False -> Normal
    },
    disabled: case can_be_disabled(config.type_) {
      True -> config.disabled
      False -> False
    },
    selected: case can_be_selected(config.type_) {
      True -> config.selected
      False -> False
    },
  )
}

fn default(label: String, type_: Type) -> Chip {
  from_config(ChipConfig(..default_config(label), type_: type_))
}

pub fn assist(label: String) -> Chip {
  default(label, Assist)
}

pub fn filter(label: String) -> Chip {
  default(label, Filter)
}

pub fn information(label: String) -> Chip {
  default(label, Information)
}

pub fn input(label: String) -> Chip {
  default(label, Input)
}

pub fn suggestion(label: String) -> Chip {
  default(label, Suggestion)
}

// --- SETTERS ---

pub fn behaviour(c: Chip, b: Behaviour) -> Chip {
  case can_have_behaviour(c.type_) {
    True -> Chip(..c, behaviour: b)
    False -> c
  }
}

pub fn disabled(c: Chip, d: Bool) -> Chip {
  case can_be_disabled(c.type_) {
    True -> Chip(..c, disabled: d)
    False -> c
  }
}

pub fn selected(c: Chip, s: Bool) -> Chip {
  case can_be_selected(c.type_) {
    True -> Chip(..c, selected: s)
    False -> c
  }
}

pub fn variant(c: Chip, v: Variant) -> Chip {
  Chip(..c, variant: v)
}

// ... (remaining setters for icon, form, removable follow the same pattern)

// --- RENDERING ---

pub fn render(
  c: Chip,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    type_to_string(c.type_),
    flatten([
      [
        behaviour_attr(c.type_, c.behaviour),
        disabled_attr(c.type_, c.disabled),
        removable_attr(c.type_, c.removable),
        selected_attr(c.type_, c.selected),
        variant_attr(c.variant),
      ],
      form_submission.attributes(c.form_submission),
      attributes,
    ])
      |> list.filter(fn(a) { a != none() }),
    append([icon_element(c.type_, c.icon), text(c.label)], children),
  )
}

// --- PRIVATE INTERNAL HELPERS ---

fn type_to_string(t: Type) -> String {
  case t {
    Information -> "m3e-chip"
    Assist -> "m3e-assist-chip"
    Filter -> "m3e-filter-chip"
    Input -> "m3e-input-chip"
    Suggestion -> "m3e-suggestion-chip"
  }
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Elevated -> "elevated"
    Outlined -> "outlined"
  }
}

fn behaviour_attr(t: Type, b: Behaviour) -> Attribute(msg) {
  case t, b {
    Assist, Reset | Suggestion, Reset -> attribute("type", "reset")
    Assist, Submit | Suggestion, Submit -> attribute("type", "submit")
    _, _ -> none()
  }
}

fn disabled_attr(t: Type, disabled: Bool) -> Attribute(msg) {
  case t, disabled {
    Assist, True | Filter, True | Suggestion, True -> attribute("disabled", "")
    _, _ -> none()
  }
}

fn variant_attr(v: Variant) -> Attribute(msg) {
  attribute("variant", variant_to_string(v))
}

fn selected_attr(t: Type, selected: Bool) -> Attribute(msg) {
  case t, selected {
    Filter, True -> attribute("selected", "")
    _, _ -> none()
  }
}

fn removable_attr(t: Type, removable: Bool) -> Attribute(msg) {
  case t, removable {
    Input, True -> attribute("removable", "")
    _, _ -> none()
  }
}

fn icon_element(t: Type, icon: Option(Icon)) -> Element(msg) {
  case t, icon {
    Assist, Some(i) | Suggestion, Some(i) -> icon.render(i, [], [])
    Filter, Some(i) | Information, Some(i) -> icon.render(i, [], [])
    _, _ -> element.none()
  }
}
// import chip
// import gleam/option.{None}

// pub fn from_config_sanitization_test() {
//   // 1. Setup an invalid configuration
//   let config = chip.ChipConfig(
//     ..chip.default_config("Invalid Test"),
//     type_: chip.Input,
//     selected: True, 
//   )

//   // 2. Convert to the opaque type
//   let c = chip.from_config(config)

//   // 3. Verify that the validation logic corrected the state
//   // Even though we requested 'True', the getter should return 'False'
//   let assert False = chip.is_selected(c)
// }

// pub fn assist_behaviour_test() {
//   let c = chip.assist("Help")

//   // Verify default behaviour is Normal
//   let assert chip.Normal = chip.get_behaviour(c)

//   // Update to Reset and verify
//   let updated = chip.behaviour(c, chip.Reset)
//   let assert chip.Reset = chip.get_behaviour(updated)
// }
