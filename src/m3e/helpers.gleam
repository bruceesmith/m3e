import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute}

/// boolean_attribute creates an HTML boolean attribute (or nothing)
///
pub fn boolean_attribute(name: String, value: Bool) -> Attribute(msg) {
  case value {
    True -> attribute(name, "")
    False -> attribute.none()
  }
}

/// clamp_with_default validates that an integer value is within a given range. If it is
/// then the value itself is returned, else a default value is returned
///
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
/// - default_value: default Option value if `optional_value` is None
///
pub fn option_attribute(
  option: Option(a),
  attribute_name_func: fn(a) -> String,
  attribute_value_func: fn(a) -> String,
  default_value: Option(a),
) -> Attribute(msg) {
  case option {
    Some(v) -> attribute(attribute_name_func(v), attribute_value_func(v))
    None ->
      case default_value {
        Some(dv) -> attribute(attribute_name_func(dv), attribute_value_func(dv))
        None -> attribute.none()
      }
  }
}
