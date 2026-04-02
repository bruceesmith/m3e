//// toc provides Lustre support for the [M3E Toc Item component](https://matraic.github.io/m3e/#/components/toc.html)

import gleam/list
import m3e/helpers

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/state.{type Interaction}

// --- Types ---

/// TocItem is an item in a table of contents
/// 
/// ## Fields:
/// - disabled: A value indicating whether the element is disabled
///
pub opaque type TocItem {
  TocItem(disabled: Interaction)
}

// --- CONFIGURATION ---

// --- CONSTRUCTORS ---

/// new creates a new TocItem 
///
pub fn new() -> TocItem {
  TocItem(disabled: state.default_interaction)
}

// --- SETTERS ---

/// disabled sets the disabled field
///
pub fn disabled(_: TocItem, disabled: Interaction) -> TocItem {
  TocItem(disabled: disabled)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a TocItem
///
pub fn render(
  t: TocItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-toc-item",
    list.append(
      [helpers.boolean_attribute("disabled", t.disabled == state.Disabled)],
      attributes,
    ),
    children,
  )
}
// --- PRIVATE HELPER FUNCTIONS ---
