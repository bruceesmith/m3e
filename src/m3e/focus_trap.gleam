//// FocusTrap is a non-visual element used to trap focus within nested content.
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

/// FocusTrap is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Disables the focus trap.
///
pub opaque type FocusTrap {
  FocusTrap(disabled: Disabled)
}

/// Disabled is disables the focus trap.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

// --- Constructors ---

/// new creates a new FocusTrap with the default configuration.
///
pub fn new(disabled: Disabled) -> FocusTrap {
  FocusTrap(disabled: disabled)
}

// --- Setters ---

/// disabled sets the value of disabled for this FocusTrap.
///
pub fn disabled(_: FocusTrap, disabled: Disabled) -> FocusTrap {
  FocusTrap(disabled: disabled)
}

// --- Renderers ---

/// render creates a Lustre Element for a FocusTrap
///
pub fn render(
  model: FocusTrap,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-focus-trap",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}
