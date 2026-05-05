//// Select is a form control that allows users to select a value from a set of predefined options.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// Select is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - hide_selection_indicator: Whether to hide the selection indicator for single select options.
/// - multi: Whether multiple options can be selected.
/// - name: The name that identifies the element when submitting the associated form.
/// - panel_class: Class or list of classes to be applied to the select's overlay panel.
/// - required: Whether the element is required.
///
pub opaque type Select {
  Select(
    disabled: Disabled,
    hide_selection_indicator: HideSelectionIndicator,
    multi: Multi,
    name: String,
    panel_class: String,
    required: Required,
  )
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// HideSelectionIndicator is whether to hide the selection indicator for single select options.
///
pub type HideSelectionIndicator {
  IsHideSelectionIndicator
  IsNotHideSelectionIndicator
}

/// Multi is whether multiple options can be selected.
///
pub type Multi {
  IsMulti
  IsNotMulti
}

/// Required is whether the element is required.
///
pub type Required {
  IsRequired
  IsNotRequired
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_hide_selection_indicator: HideSelectionIndicator = IsNotHideSelectionIndicator

pub const default_multi: Multi = IsNotMulti

pub const default_name: String = ""

pub const default_panel_class: String = ""

pub const default_required: Required = IsNotRequired

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Arrow
  // Renders the dropdown arrow.
  Value
  // Renders the selected value(s).
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    hide_selection_indicator: HideSelectionIndicator,
    multi: Multi,
    name: String,
    panel_class: String,
    required: Required,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    hide_selection_indicator: IsNotHideSelectionIndicator,
    multi: IsNotMulti,
    name: "",
    panel_class: "",
    required: IsNotRequired,
  )
}

// --- Constructors ---

/// from_config creates a new Select from the given configuration.
///
pub fn from_config(config: Config) -> Select {
  Select(
    disabled: config.disabled,
    hide_selection_indicator: config.hide_selection_indicator,
    multi: config.multi,
    name: config.name,
    panel_class: config.panel_class,
    required: config.required,
  )
}

/// new creates a new Select with the default configuration.
///
pub fn new() -> Select {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this Select.
///
pub fn disabled(record: Select, disabled: Disabled) -> Select {
  Select(..record, disabled: disabled)
}

/// hide_selection_indicator sets the value of hide_selection_indicator for this Select.
///
pub fn hide_selection_indicator(
  record: Select,
  hide_selection_indicator: HideSelectionIndicator,
) -> Select {
  Select(..record, hide_selection_indicator: hide_selection_indicator)
}

/// multi sets the value of multi for this Select.
///
pub fn multi(record: Select, multi: Multi) -> Select {
  Select(..record, multi: multi)
}

/// name sets the value of name for this Select.
///
pub fn name(record: Select, name: String) -> Select {
  Select(..record, name: name)
}

/// panel_class sets the value of panel_class for this Select.
///
pub fn panel_class(record: Select, panel_class: String) -> Select {
  Select(..record, panel_class: panel_class)
}

/// required sets the value of required for this Select.
///
pub fn required(record: Select, required: Required) -> Select {
  Select(..record, required: required)
}

// --- Renderers ---

/// render creates a Lustre Element for a Select
///
pub fn render(
  model: Select,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-select",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean(
          "hide-selection-indicator",
          model.hide_selection_indicator == IsHideSelectionIndicator,
        ),
        attr.boolean("multi", model.multi == IsMulti),
        attr.with_default("name", model.name, default_name),
        attr.with_default("panel-class", model.panel_class, default_panel_class),
        attr.boolean("required", model.required == IsRequired),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Select Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Arrow -> attribute.attribute("slot", "arrow")
    Value -> attribute.attribute("slot", "value")
  }
}
