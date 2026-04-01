//// form_field provides Lustre support for the [M3E Form Field component](https://matraic.github.io/m3e/#/components/form-field.html)

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers

// --- Types ---

/// When a form field's control is empty, the label is presented over the control instead of above. 
/// This behavior can be changed using the float-label attribute
/// 
pub type FloatLabel {
  Always
  Auto
}

pub const default_float_label = Auto

/// FormField is a container for form controls that applies Material Design styling and behavior. 
/// Supported controls include: input, select, textarea, and m3e-input-chip-set
/// 
/// ## Fields:
/// - float_label: Specifies whether the label should float always or only when necessary
/// - hide_required_marker: Whether the required marker should be hidden
/// - hide_subscript: Whether subscript content is hidden
/// - variant: The appearance variant of the field
/// 
pub opaque type FormField {
  FormField(
    float_label: FloatLabel,
    hide_required_marker: RequiredMarkerVisibility,
    hide_subscript: HideSubscript,
    variant: Variant,
  )
}

/// Hint labels are additional descriptive text that appear in a field's subscript
/// 
pub type HideSubscript {
  AlwaysHide
  AutoHide
  NeverHide
}

pub const default_hide_subscript = AutoHide

/// RequiredMarkerVisibility specifies if the required marker should be hidden or shown
/// 
pub type RequiredMarkerVisibility {
  ShowRequiredMarker
  HideRequiredMarker
}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  Error
  // Renders error text in the fields's subscript, when the control is invalid 
  Hint
  // Renders hint text in the fields's subscript, when the control is valid 
  Prefix
  // Renders content before the fields's control 
  PrefixText
  // Renders text before the fields's control 
  Suffix
  // Renders content after the fields's control 
  SuffixText
  // Renders text after the fields's control 
}

/// Variant is the appearance variant of the field
/// 
pub type Variant {
  Filled
  Outlined
}

pub const default_variant = Outlined

// --- CONFIGURATION ---

/// Config holds the configuration for a FormField
/// 
pub type Config {
  Config(
    float_label: FloatLabel,
    hide_required_marker: RequiredMarkerVisibility,
    hide_subscript: HideSubscript,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    float_label: default_float_label,
    hide_required_marker: ShowRequiredMarker,
    hide_subscript: default_hide_subscript,
    variant: default_variant,
  )
}

// --- CONSTRUCTORS ---

/// new creates a FormField with default values
/// 
pub fn new() -> FormField {
  from_config(default_config())
}

/// from_config creates a FormField from a Config record
/// 
pub fn from_config(c: Config) -> FormField {
  FormField(
    float_label: c.float_label,
    hide_required_marker: c.hide_required_marker,
    hide_subscript: c.hide_subscript,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// float_label sets the `float_label` field
/// 
pub fn float_label(f: FormField, float_label: FloatLabel) -> FormField {
  FormField(..f, float_label: float_label)
}

/// hide_hide_required_marker sets the `hide_required_marker` field
/// 
pub fn hide_required_marker(
  f: FormField,
  visibility: RequiredMarkerVisibility,
) -> FormField {
  FormField(..f, hide_required_marker: visibility)
}

/// hide_subscript sets the `hide_subscript` field
/// 
pub fn hide_subscript(f: FormField, hide_subscript: HideSubscript) -> FormField {
  FormField(..f, hide_subscript: hide_subscript)
}

/// variant sets the `variant` field
/// 
pub fn variant(f: FormField, variant: Variant) -> FormField {
  FormField(..f, variant: variant)
}

// --- RENDERING ---

/// render creates a Lustre Element from a FormField
/// 
/// ## Parameters:
/// - f: a FormField
/// - attributes: a list of additional attributes
/// - children: a list of child Elements
/// 
pub fn render(
  f: FormField,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-form-field",
    [
      attribute.attribute("float-label", float_label_to_string(f.float_label)),
      helpers.boolean_attribute(
        "hide-required-marker",
        f.hide_required_marker == HideRequiredMarker,
      ),
      attribute.attribute(
        "hide-subscript",
        hide_subscript_to_string(f.hide_subscript),
      ),
      attribute.attribute("variant", variant_to_string(f.variant)),
      ..attributes
    ]
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config), attributes, children)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Error -> attribute.attribute("slot", "error")
    Hint -> attribute.attribute("slot", "hint")
    Prefix -> attribute.attribute("slot", "prefix")
    PrefixText -> attribute.attribute("slot", "prefix-text")
    Suffix -> attribute.attribute("slot", "suffix")
    SuffixText -> attribute.attribute("slot", "suffix-text")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

fn float_label_to_string(f: FloatLabel) -> String {
  case f {
    Always -> "always"
    Auto -> "auto"
  }
}

fn hide_subscript_to_string(h: HideSubscript) -> String {
  case h {
    AlwaysHide -> "always"
    AutoHide -> "auto"
    NeverHide -> "never"
  }
}

/// variant_to_string converts a Variant to a string
/// 
fn variant_to_string(v: Variant) -> String {
  case v {
    Filled -> "filled"
    Outlined -> "outlined"
  }
}
