//// option_panel provides Lustre support for the [M3E Option Panel component](https://matraic.github.io/m3e/#/components/option.html)

import lustre/element.{type Element, element}

/// OptionPanel holds all information to create an OptionPanel
///
/// ## Fields:
/// - no fields are defined
/// 
pub type OptionPanel {
  OptionPanel
}

/// new creates a new OptionPanel
///
/// ## Parameters:
/// - no parameters are defined
/// 
pub fn new() -> OptionPanel {
  OptionPanel
}

/// render creates an M3E OptionPanel component from an OptionPanel
///
pub fn render(_: OptionPanel, children: List(Element(msg))) -> Element(msg) {
  element("m3e-option-panel", [], children)
}
