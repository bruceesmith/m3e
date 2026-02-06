//// optgroup provides Lustre support for the [M3E Optgroupcomponent](https://matraic.github.io/m3e/#/components/option.html)

import lustre/element.{type Element, element}

/// Optgroup holds all information to create an Optgroup
///
/// ## Fields:
/// - no fields are defined
/// 
pub type Optgroup {
  Optgroup
}

/// new creates a new Optgroup
///
/// ## Parameters:
/// - no parameters are defined
/// 
pub fn new() -> Optgroup {
  Optgroup
}

/// render creates an M3E Optgroup component from an Optgroup
///
pub fn render(_: Optgroup, children: List(Element(msg))) -> Element(msg) {
  element("m3e-option-panel", [], children)
}
