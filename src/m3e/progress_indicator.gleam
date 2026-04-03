//// progress_indicator provides Lustre support for the [M3E Progress Indicator component](https://matraic.github.io/m3e/#/components/progress-indicator.html)

// --- Types ---

/// Variant is the appearance of the indicator
/// 
pub type Variant {
  Flat
  Wavy
}

pub const default_variant = Flat

// --- CONFIGURATION ---

// --- CONSTRUCTORS ---

// --- SETTERS ---

// --- RENDERING ---

// --- PRIVATE INTERNAL HELPERS ---

pub fn variant_to_string(variant: Variant) -> String {
  case variant {
    Flat -> "flat"
    Wavy -> "wavy"
  }
}
