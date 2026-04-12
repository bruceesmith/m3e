//// datepicker_toggle provides Lustre support for the [M3E Datepicker Toggle component](https://matraic.github.io/m3e/#/components/datepicker.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers

// --- Types ---

/// DatepickerToggle is an element, nested within a clickable element, used to toggle a datepicker
///
/// ## Fields:
/// - for: The identifier of the interactive control to which this element is attached
///
pub opaque type DatepickerToggle {
  DatepickerToggle(for: Option(String))
}

// --- CONSTRUCTORS ---

pub fn new(for: Option(String)) -> DatepickerToggle {
  DatepickerToggle(for: for)
}

// --- RENDERING ---

pub fn render(
  toggle: DatepickerToggle,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  element.element(
    "m3e-datepicker-toggle",
    [
      helpers.option_attribute(
        toggle.for,
        fn(_) { "for" },
        function.identity,
        None,
      ),
      ..attributes
    ]
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}
