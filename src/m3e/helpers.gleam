import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute}

/// boolean_attribute creates an HTML boolean attribute (or nothing)
///
@internal
pub fn boolean_attribute(name: String, value: Bool) -> Attribute(msg) {
  case value {
    True -> attribute.attribute(name, "")
    False -> attribute.none()
  }
}

/// clamp_with_default validates that an integer value is within a given range. If it is
/// then the value itself is returned, else a default value is returned
///
@internal
pub fn clamp_with_default(value: Int, min: Int, max: Int, default: Int) -> Int {
  case value >= min && value <= max {
    True -> value
    False -> default
  }
}

/// option_attribute creates an HTML attribute if an Option(a) has
/// a value, else it creates either a default or attribute.none()
///
/// ## Parameters:
/// - option: the Option value to convert to a Lustre Attribute(msg)
/// - attribute_name_func: function to create the attribute's name
/// - attribute_value_func: function to create the attribute's value
/// - default_value: default Option value if `option` is None
///
@internal
pub fn option_attribute(
  option: Option(a),
  attribute_name_func: fn(a) -> String,
  attribute_value_func: fn(a) -> String,
  default_value: Option(a),
) -> Attribute(msg) {
  case option.or(option, default_value) {
    Some(v) ->
      attribute.attribute(attribute_name_func(v), attribute_value_func(v))
    None -> attribute.none()
  }
}

/// slot is a shorthand for attribute.attribute("slot", name)
///
@internal
pub fn slot(name: String) -> Attribute(msg) {
  attribute.attribute("slot", name)
}
