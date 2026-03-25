///// fab provides Lustre support for the [M3E FAB component](https://matraic.github.io/m3e/#/components/fab.html)

import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

import m3e/config.{type Size}
import m3e/form_submission.{type FormSubmission}
import m3e/helpers
import m3e/link.{type Link}

// --- Types ---

/// Elevation specifies the elevation of the element
/// 
pub type Elevation {
  Raised
  Lowered
}

pub const default_elevation: Elevation = Raised

///
/// Extension specifies if the element is extended
/// 
pub type Extension {
  Extended
  NotExtended
}

pub const default_extension: Extension = NotExtended

///
/// FAB is a floating action button (FAB) used to present important actions
/// 
/// ## Fields:
/// - interaction: Whether the element is enabled or disabled
/// - extension: Whether the element is extended
/// - extended_label: Renders the label of an extended button
/// - form_submission: handles this element's role in form submission
/// - link: Whether the element is a link
/// - elevation: Whether to present a lowered elevation
/// - size: The size of the button
/// - variant: The appearance variant of the button
/// 
pub opaque type FAB {
  FAB(
    interaction: Interaction,
    extension: Extension,
    extended_label: Option(String),
    form_submission: Option(FormSubmission),
    link: Option(Link),
    elevation: Elevation,
    size: Size,
    variant: Variant,
  )
}

/// Interaction specifies if the element is enabled or disabled
/// 
pub type Interaction {
  Enabled
  Disabled
  DisabledInteractive
}

pub const default_interaction: Interaction = Enabled

/// Default size
/// 
pub const default_size: Size = config.Medium

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  CloseIcon
  // Renders the close icon when used to open a FAB menu 
  Label
  // Renders the label of an extended button 
  MenuItemIcon
  // Renders an icon before the items's label 
}

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

pub const default_variant = PrimaryContainer

// --- CONFIGURATION ---

/// Config holds the configuration for a FAB
/// 
pub type Config {
  Config(
    interaction: Interaction,
    extension: Extension,
    extended_label: Option(String),
    form_submission: Option(FormSubmission),
    link: Option(Link),
    elevation: Elevation,
    size: Size,
    variant: Variant,
  )
}

/// default_config creates a new Config with default values
/// 
pub fn default_config() -> Config {
  Config(
    interaction: default_interaction,
    extension: default_extension,
    extended_label: None,
    form_submission: None,
    link: None,
    elevation: default_elevation,
    size: default_size,
    variant: default_variant,
  )
}

// --- CONSTRUCTORS ---

/// new creates a new FAB with default values
/// 
pub fn new() -> FAB {
  from_config(default_config())
}

/// from_config creates a FAB from a Config record
/// 
pub fn from_config(c: Config) -> FAB {
  FAB(
    interaction: c.interaction,
    extension: c.extension,
    extended_label: c.extended_label,
    form_submission: c.form_submission,
    link: c.link,
    elevation: c.elevation,
    size: c.size,
    variant: c.variant,
  )
}

// --- SETTERS ---

/// disabled sets the `interaction` field
/// 
pub fn disabled(f: FAB, interaction: Interaction) -> FAB {
  FAB(..f, interaction: interaction)
}

/// extended sets the `extension` field
/// 
pub fn extended(f: FAB, extension: Extension) -> FAB {
  FAB(..f, extension: extension)
}

/// extended_label sets the extended_label field
/// 
pub fn extended_label(f: FAB, extended_label: Option(String)) -> FAB {
  FAB(..f, extended_label: extended_label)
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

/// lowered sets the `elevation` field
/// 
pub fn lowered(f: FAB, elevation: Elevation) -> FAB {
  FAB(..f, elevation: elevation)
}

/// size sets the size field
/// 
pub fn size(f: FAB, size: Size) -> FAB {
  FAB(..f, size: config.clamp_to_restricted_size(size, default_size))
}

/// variant sets the variant field
/// 
pub fn variant(f: FAB, variant: Variant) -> FAB {
  FAB(..f, variant: variant)
}

// --- RENDERING ---

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
  element.element(
    "m3e-fab",
    list.flatten([
      [
        helpers.boolean_attribute("disabled", f.interaction == Disabled),
        helpers.boolean_attribute(
          "disabled-interactive",
          f.interaction == DisabledInteractive,
        ),
        helpers.boolean_attribute("extended", f.extension == Extended),
        helpers.boolean_attribute("lowered", f.elevation == Lowered),
        attribute.attribute(
          "size",
          config.size_to_string(config.clamp_to_restricted_size(
            f.size,
            default_size,
          )),
        ),
        attribute.attribute("variant", variant_to_string(f.variant)),
      ],
      form_submission.button_attributes(f.form_submission),
      link.attributes(f.link),
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    [extended_label_elt(f.extended_label), ..children]
      |> list.filter(fn(a) { a != element.none() }),
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
    CloseIcon -> attribute.attribute("slot", "close-icon")
    Label -> attribute.attribute("slot", "label")
    MenuItemIcon -> attribute.attribute("slot", "icon")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

/// extended_label_elt sets the extended_label_elt field
/// 
fn extended_label_elt(el: Option(String)) -> Element(msg) {
  case el {
    Some(label) -> html.span([slot(Label)], [element.text(label)])
    None -> element.none()
  }
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
