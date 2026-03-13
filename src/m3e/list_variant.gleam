//// list_variant provides Lustre support for the [M3E List Variant type component](https://matraic.github.io/m3e/#/components/list.html)

// --- Types ---

/// Variant specifies the possible appearance variants of a list
///
pub type Variant {
  Standard
  Segmented
}

pub const default_variant: Variant = Standard

/// variant_to_string converts a Variant to a string
/// 
pub fn variant_to_string(v: Variant) -> String {
  case v {
    Standard -> "standard"
    Segmented -> "segmented"
  }
}
