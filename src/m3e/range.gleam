import gleam/int

/// range checks that an integer is within a given range
///
@internal
pub fn range(i: Int, min: Int, max: Int) -> Result(Int, String) {
  case i >= min && i <= max {
    True -> Ok(i)
    False ->
      Error(
        int.to_string(i)
        <> " is out of range >="
        <> int.to_string(min)
        <> " and <="
        <> int.to_string(max),
      )
  }
}
