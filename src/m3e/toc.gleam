//// Toc is a table of contents that provides in-page scroll navigation.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/float
import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// Toc is a View Model for this component
///
/// ## Fields:
///
/// - for: The identifier of the interactive control to which this element is attached.
/// - max_depth: The maximum depth of the table of contents.
///
pub opaque type Toc {
  Toc(for: Option(String), max_depth: Float)
}

// --- Defaults ---

pub const default_for: Option(String) = None

pub const default_max_depth: Float = 2.0

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Overline
  // Renders the overline of the table of contents.
  Title
  // Renders the title of the table of contents.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(for: Option(String), max_depth: Float)
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(for: None, max_depth: 2.0)
}

// --- Constructors ---

/// from_config creates a new Toc from the given configuration.
///
pub fn from_config(config: Config) -> Toc {
  Toc(for: config.for, max_depth: config.max_depth)
}

/// new creates a new Toc with the default configuration.
///
pub fn new() -> Toc {
  from_config(default_config())
}

// --- Setters ---

/// for sets the value of for for this Toc.
///
pub fn for(record: Toc, for: Option(String)) -> Toc {
  Toc(..record, for: for)
}

/// max_depth sets the value of max_depth for this Toc.
///
pub fn max_depth(record: Toc, max_depth: Float) -> Toc {
  Toc(..record, max_depth: max_depth)
}

// --- Renderers ---

/// render creates a Lustre Element for a Toc
///
pub fn render(
  model: Toc,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-toc",
    list.flatten([
      [
        attr.option(model.for, fn(_) { "for" }, function.identity, default_for),
        attr.with_default(
          "max-depth",
          float.to_string(model.max_depth),
          float.to_string(default_max_depth),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Toc Config
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
    Overline -> attribute.attribute("slot", "overline")
    Title -> attribute.attribute("slot", "title")
  }
}
