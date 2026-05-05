//// DialogTrigger is an element, nested within a clickable element, used to open a dialog.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr

// --- Types ---

/// DialogTrigger is a View Model for this component
///
/// ## Fields:
///
/// - for: The identifier of the interactive control to which this element is attached.
///
pub opaque type DialogTrigger {
  DialogTrigger(for: Option(String))
}

// --- Defaults ---

pub const default_for: Option(String) = None

// --- Constructors ---

/// new creates a new DialogTrigger with the default configuration.
///
pub fn new(for: Option(String)) -> DialogTrigger {
  DialogTrigger(for: for)
}

// --- Setters ---

/// for sets the value of for for this DialogTrigger.
///
pub fn for(_: DialogTrigger, for: Option(String)) -> DialogTrigger {
  DialogTrigger(for: for)
}

// --- Renderers ---

/// render creates a Lustre Element for a DialogTrigger
///
pub fn render(
  model: DialogTrigger,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-dialog-trigger",
    list.flatten([
      [
        attr.option(model.for, fn(_) { "for" }, function.identity, default_for),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}
