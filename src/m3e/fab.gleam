///// fab provides Lustre support for the [M3E FAB component](https://matraic.github.io/m3e/#/components/fab.html)

import gleam/list.{filter, flatten}
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{span, text}

import m3e/form_submission.{type FormSubmission}
import m3e/helpers.{boolean_attribute, slot}
import m3e/link.{type Link}

/// Size is the size of the bar
/// 
pub type Size {
  Large
  Medium
  Small
}

fn size_to_string(size: Size) -> String {
  case size {
    Large -> "large"
    Medium -> "medium"
    Small -> "small"
  }
}

/// Default size
/// 
pub const default_size = Medium

/// Variant is the appearance variant of the button
/// 
pub type Variant {
  Primary
  PrimaryContainer
  Secondary
  SecondaryContainer
  Surface
  Tertiary
  TertiaryContainer
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Primary -> "primary"
    PrimaryContainer -> "primary-container"
    Secondary -> "secondary"
    SecondaryContainer -> "secondary-container"
    Surface -> "surface"
    Tertiary -> "tertiary"
    TertiaryContainer -> "tertiary-container"
  }
}

pub const default_variant = PrimaryContainer

/// FAB is a floating action button (FAB) used to present important actions
/// 
/// ## Fields:
/// - disabled: Whether the element is disabled
/// - disabled_interactive: Whether the element is disabled and interactive
/// - extended: Whether the element is extended
/// - extended_label: Renders the label of an extended button
/// - form_submission: handles this element's role in form submission
/// - link: Whether the element is a link
/// - lowered: Whether to present a lowered elevation
/// - size: The size of the button
/// - variant: The appearance variant of the button
/// 
pub opaque type FAB {
  FAB(
    disabled: Bool,
    disabled_interactive: Bool,
    extended: Bool,
    extended_label: Option(String),
    form_submission: Option(FormSubmission),
    link: Option(Link),
    lowered: Bool,
    size: Size,
    variant: Variant,
  )
}

/// new creates a new FAB
/// 
pub fn new() -> FAB {
  FAB(
    disabled: False,
    disabled_interactive: False,
    extended: False,
    extended_label: None,
    form_submission: None,
    link: None,
    lowered: False,
    size: default_size,
    variant: default_variant,
  )
}

/// render creates a Lustre Element from a FAB
///
/// ## Parameters:
/// - f: a FAB
/// - attributes: a list of additional Attributes
/// - children: a list of child Elements
///
pub fn render(
  f: FAB,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-fab",
    flatten([
      [
        boolean_attribute("disabled", f.disabled),
        boolean_attribute("disabled-interactive", f.disabled_interactive),
        boolean_attribute("extended", f.extended),
        boolean_attribute("lowered", f.lowered),
        attribute("size", size_to_string(f.size)),
        attribute("variant", variant_to_string(f.variant)),
      ],
      form_submission.button_attributes(f.form_submission),
      link.attributes(f.link),
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    [extended_label_elt(f.extended_label), ..children]
      |> filter(fn(a) { a != element.none() }),
  )
}

/// disabled sets the disabled field
/// 
pub fn disabled(f: FAB, disabled: Bool) -> FAB {
  FAB(..f, disabled: disabled)
}

/// disabled_interactive sets the disabled_interactive field
/// 
pub fn disabled_interactive(f: FAB, disabled_interactive: Bool) -> FAB {
  FAB(..f, disabled_interactive: disabled_interactive)
}

/// extended sets the extended field
/// 
pub fn extended(f: FAB, extended: Bool) -> FAB {
  FAB(..f, extended: extended)
}

/// extended_label sets the extended_label field
/// 
pub fn extended_label(f: FAB, extended_label: Option(String)) -> FAB {
  FAB(..f, extended_label: extended_label)
}

/// extended_label_elt sets the extended_label_elt field
/// 
fn extended_label_elt(el: Option(String)) -> Element(msg) {
  case el {
    Some(label) -> span([slot("label")], [text(label)])
    None -> element.none()
  }
}

/// form sets the form_submission field
/// 
pub fn form(f: FAB, form_submission: Option(FormSubmission)) -> FAB {
  FAB(..f, form_submission: form_submission)
}

/// link sets the link field
/// 
pub fn link(f: FAB, link: Option(Link)) -> FAB {
  FAB(..f, link: link)
}

/// lowered sets the lowered field
/// 
pub fn lowered(f: FAB, lowered: Bool) -> FAB {
  FAB(..f, lowered: lowered)
}

/// size sets the size field
/// 
pub fn size(f: FAB, size: Size) -> FAB {
  FAB(..f, size: size)
}

/// variant sets the variant field
/// 
pub fn variant(f: FAB, variant: Variant) -> FAB {
  FAB(..f, variant: variant)
}
