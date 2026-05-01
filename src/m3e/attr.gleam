import gleam/list
import gleam/option.{type Option, None, Some}

import lustre/attribute.{type Attribute}

/// boolean creates an HTML boolean attribute (or nothing)
///
@internal
pub fn boolean(name: String, value: Bool) -> Attribute(msg) {
  case value {
    True -> attribute.attribute(name, "")
    False -> attribute.none()
  }
}

/// list_of_string creates an HTML attribute with a space-separated list of strings
/// as its value (or nothing if the list is empty)
///
@internal
pub fn list_of_string(name: String, value: List(String)) -> Attribute(msg) {
  case value {
    [] -> attribute.none()
    [_, _, ..] | [_] ->
      attribute.attribute(
        name,
        list.fold(value, "", fn(acc, s) {
          case acc {
            "" -> s
            _ -> acc <> " " <> s
          }
        }),
      )
  }
}

/// option creates an HTML attribute if an Option(a) has
/// a value, else it creates either a default or attribute.none()
///
/// ## Parameters:
/// - option: the Option value to convert to a Lustre Attribute(msg)
/// - attribute_name_func: function to create the attribute's name
/// - attribute_value_func: function to create the attribute's value
/// - default_value: default Option value if `option` is None
///
@internal
pub fn option(
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

/// with_default saves us from needlessly adding an attribute to an
/// HTML element when the value of the attribute is its default
///
@internal
pub fn with_default(
  name: String,
  value: String,
  default: String,
) -> Attribute(msg) {
  case value != default {
    True -> attribute.attribute(name, value)
    False -> attribute.none()
  }
}
