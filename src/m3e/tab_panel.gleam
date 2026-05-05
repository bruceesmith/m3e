//// TabPanel is a panel presented for a tab.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

// --- Types ---

/// TabPanel is a View Model for this component
///
pub opaque type TabPanel {
  TabPanel
}

// --- Defaults ---

// --- Constructors ---

/// new creates a new TabPanel with the default configuration.
///
pub fn new() -> TabPanel {
  TabPanel
}

// --- Setters ---

// --- Renderers ---

/// render creates a Lustre Element for a TabPanel
///
pub fn render(
  _: TabPanel,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("m3e-tab-panel", attributes, children)
}
