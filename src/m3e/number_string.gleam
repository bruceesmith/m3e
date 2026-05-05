/// NumberString is an attribute type that can hold either a number or a string.
///
import gleam/float

pub type NumberString {
  NumberVal(Float)
  StringVal(String)
}

pub fn to_string(n: NumberString) -> String {
  case n {
    NumberVal(f) -> float.to_string(f)
    StringVal(s) -> s
  }
}
