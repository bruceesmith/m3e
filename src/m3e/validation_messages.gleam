import gleam/dict.{type Dict}

/// Represents either a static message string or a dynamic callback
/// that receives a DOM element (or Lustre element context) and returns a string.
pub type ValidationMessage(element) {
  StaticMessage(String)
  DynamicMessage(fn(element) -> String)
}

/// Enumeration representing the standard keyof ValidityStateFlags.
pub type ValidityFlag {
  ValueMissing
  TypeMismatch
  PatternMismatch
  TooLong
  TooShort
  RangeUnderflow
  RangeOverflow
  StepMismatch
  BadInput
  CustomError
}

/// ValidationMessages represented as a dictionary mapping flags to messages.
pub type ValidationMessages(element) =
  Dict(ValidityFlag, ValidationMessage(element))
