//// switch provides Lustre support for the [M3E Switch component](https://matraic.github.io/m3e/#/components/switch.html)

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}
import lustre/element/html.{text}
import m3e/helpers.{boolean_attribute, option_attribute}

pub type Icons {
  Both
  Neither
  Selected
}

fn icons_to_string(i: Icons) -> String {
  case i {
    Both -> "both"
    Neither -> "none"
    Selected -> "selected"
  }
}

/// Switch is a configuration type representing an M3E Switch
/// 
/// ## Fields:
/// - id: id of the switch,
/// - label: label on the switch
/// - icons: The icons to present
/// - checked: Whether the element is checked
/// - disabled: Whether the element is disabled
/// - name: the name under which the component's value is submitted in a form
/// - value: the value which is submitted in a form
/// 
pub opaque type Switch {
  Switch(
    id: String,
    label: String,
    icons: Icons,
    checked: Bool,
    disabled: Bool,
    name: Option(String),
    value: Option(String),
  )
}

/// new creates a Switch with default values
///
pub fn new(id: String, label: String) -> Switch {
  Switch(
    id: id,
    label: label,
    icons: Neither,
    checked: False,
    disabled: False,
    name: None,
    value: None,
  )
}

/// checked sets the checked field
///
pub fn checked(s: Switch, checked: Bool) -> Switch {
  Switch(..s, checked: checked)
}

/// disabled sets the disabled field
///
pub fn disabled(s: Switch, disabled: Bool) -> Switch {
  Switch(..s, disabled: disabled)
}

/// render creates a list of Lustre Elements from a Switch
///
pub fn render(s: Switch, attributes: List(Attribute(msg))) -> List(Element(msg)) {
  [
    element(
      "m3e-switch",
      list.append(
        [
          attribute("id", s.id),
          attribute("icons", icons_to_string(s.icons)),
          boolean_attribute("checked", s.checked),
          boolean_attribute("disabled", s.disabled),
          option_attribute(s.name, fn(_) { "name" }, function.identity, None),
          option_attribute(s.value, fn(_) { "value" }, function.identity, None),
        ],
        attributes,
      )
        |> list.filter(fn(a) { a != none() }),
      [],
    ),
    element("label", [attribute("for", s.id)], [text(s.label)]),
  ]
}

/// form sets the name and value fields
///
pub fn form(s: Switch, name: Option(String), value: Option(String)) -> Switch {
  Switch(..s, name: name, value: value)
}

/// icon sets the icons field
///
pub fn icon(s: Switch, icons: Icons) -> Switch {
  Switch(..s, icons: icons)
}

/// name sets the name field
///
pub fn name(s: Switch, name: Option(String)) -> Switch {
  Switch(..s, name: name)
}

/// value sets the value field
///
pub fn value(s: Switch, value: Option(String)) -> Switch {
  Switch(..s, value: value)
}
