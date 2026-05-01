import gleam/int

/// positive checks that an integer is positive
///
@internal
pub fn positive(i: Int) -> Result(Int, String) {
  case i > 0 {
    True -> Ok(i)
    False -> Error(int.to_string(i) <> " is not a positive integer")
  }
}
