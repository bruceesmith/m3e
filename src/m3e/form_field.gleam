//// button provides Lustre support for the [M3E Form Field component](https://matraic.github.io/m3e/#/components/form-field.html

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

import m3e/helpers.{boolean_attribute}

/// When a form field's control is empty, the label is presented over the control instead of above. 
/// This behavior can be changed using the float-label attribute
/// 
pub type FloatLabel {
  Always
  Auto
}

fn float_label_to_string(f: FloatLabel) -> String {
  case f {
    Always -> "always"
    Auto -> "auto"
  }
}

pub const default_float_label = Auto

/// Hint labels are additional descriptive text that appear in a field's subscript
/// 
pub type HideSubscript {
  AlwaysHide
  AutoHide
  NeverHide
}

fn hide_subscript_to_string(h: HideSubscript) -> String {
  case h {
    AlwaysHide -> "always"
    AutoHide -> "auto"
    NeverHide -> "never"
  }
}

pub const default_hide_subscript = AutoHide

/// Variant is the appearance variant of the field
/// 
pub type Variant {
  Filled
  Outlined
}

fn variant_to_string(v: Variant) -> String {
  case v {
    Filled -> "filled"
    Outlined -> "outlined"
  }
}

pub const default_variant = Outlined

/// FormField is a container for form controls that applies Material Design styling and behavior. 
/// Supported controls include: input, select, textarea, and m3e-input-chip-set
/// 
/// ## Fields:
/// - float_label: Specifies whether the label should float always or only when necessary
/// - hide_required_marker: Whether the required marker should be hidden
/// - hide_subscript: Whether subscript content is hidden
/// - variant: The appearance variant of the field
/// 
pub type FormField {
  FormField(
    float_label: FloatLabel,
    hide_required_marker: Bool,
    hide_subscript: HideSubscript,
    variant: Variant,
  )
}

/// form_field creates a FormField
/// 
/// ## Parameters:
/// - float_label: Specifies whether the label should float always or only when necessary
/// - hide_required_marker: Whether the required marker should be hidden
/// - hide_subscript: Whether subscript content is hidden
/// - variant: The appearance variant of the field
/// 
pub fn form_field(
  float_label: FloatLabel,
  hide_required_marker: Bool,
  hide_subscript: HideSubscript,
  variant: Variant,
) -> FormField {
  FormField(
    float_label: float_label,
    hide_required_marker: hide_required_marker,
    hide_subscript: hide_subscript,
    variant: variant,
  )
}

/// basic creates a FormField with default values
/// 
pub fn basic() -> FormField {
  FormField(default_float_label, False, default_hide_subscript, default_variant)
}

/// element creates a Lustre Element from a FormField
/// 
/// ## Parameters:
/// - f: a FormField
/// - attributes: a list of additional attributes
/// - children: a list of child Elements
/// 
pub fn element(
  f: FormField,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-form-field",
    [
      attribute("float-label", float_label_to_string(f.float_label)),
      boolean_attribute("hide-required-marker", f.hide_required_marker),
      attribute("hide-subscript", hide_subscript_to_string(f.hide_subscript)),
      attribute("variant", variant_to_string(f.variant)),
      ..attributes
    ],
    children,
  )
}

/// float_label sets the float-label attribute of a FormField
/// 
pub fn float_label(f: FormField, float_label: FloatLabel) -> FormField {
  FormField(..f, float_label: float_label)
}

/// hide_required_marker sets the hide-required-marker attribute of a FormField
/// 
pub fn hide_required_marker(
  f: FormField,
  hide_required_marker: Bool,
) -> FormField {
  FormField(..f, hide_required_marker: hide_required_marker)
}

/// hide_subscript sets the hide-subscript attribute of a FormField
/// 
pub fn hide_subscript(f: FormField, hide_subscript: HideSubscript) -> FormField {
  FormField(..f, hide_subscript: hide_subscript)
}

/// variant sets the variant attribute of a FormField
/// 
pub fn variant(f: FormField, variant: Variant) -> FormField {
  FormField(..f, variant: variant)
}
