// src/m3e/layout.gleam

/// Orientation specifies the axis along which components 
/// are arranged (e.g., in a ChipSet).
pub type Orientation {
  Horizontal
  Vertical
}

pub const default_orientation = Horizontal

/// orientation_to_string converts an Orientation to its 
/// CSS-friendly or attribute-friendly string representation.
pub fn orientation_to_string(o: Orientation) -> String {
  case o {
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}
