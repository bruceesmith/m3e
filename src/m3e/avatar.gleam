//// avatar provides Lustre support for the [M3E Avatar component](https://matraic.github.io/m3e/#/components/avatar.html)

import lustre/element.{type Element}

/// Avatar is a reusable identity primitive that displays visual or textual representation with consistent sizing, shape, and typography
/// 
pub opaque type Avatar {
  Avatar
}

/// new creates a new Avatar
/// 
pub fn new() -> Avatar {
  Avatar
}

/// render creates a Lustre Element from an Avatar
/// 
pub fn render(_: Avatar, children: List(Element(msg))) -> Element(msg) {
  element.element("m3e-avatar", [], children)
}
