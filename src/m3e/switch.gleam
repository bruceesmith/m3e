//// switch provides Lustre support for the [M3E Switch component]{https://matraic.github.io/m3e/#/components/switch.html}

import gleam/function
import gleam/list.{append}
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute, attribute, for, id}
import lustre/element.{type Element}
import lustre/element/html.{label}

import m3e/helpers.{boolean_attribute, option_attribute}

/// The icons displayed in the switch
pub type Icons {
  /// Both icons are displayed
  Both
  /// No icons are displayed
  Neither
  /// Only the selected icon is displayed
  Selected
}

fn icons_to_string(i: Icons) -> String {
  case i {
    Both -> "both"
    Neither -> "none"
    Selected -> "selected"
  }
}

/// Switch is the basis for a m3e-switch element
///
/// ## Fields:
/// - id: The id of the switch.
/// - label: The text for the label.
/// - icons: The icon(s) used in the switch
/// - checked: whether the switch is initially set
/// - disabled: Whether the switch is disabled
/// - key: the key under which the component's value is submitted in a form
/// - value: the value when the form is submitted
///
pub type Switch {
  Switch(
    id: String,
    label: String,
    icons: Icons,
    checked: Bool,
    disabled: Bool,
    key: Option(String),
    value: Option(String),
  )
}

/// switch returns a m3e-switch element and a associated label
///
/// ## Parameters:
/// - id: The id of the switch.
/// - label: The text for the label.
/// - icons: The icon(s) used in the switch
/// - checked: whether the switch is initially set
/// - disabled: Whether the switch is disabled
/// - key: the key under which the component's value is submitted in a form
/// - value: the value when the form is submitted
///
pub fn switch(
  id: String,
  label: String,
  icons: Icons,
  checked: Bool,
  disabled: Bool,
  key: Option(String),
  value: Option(String),
) -> Switch {
  Switch(
    id: id,
    label: label,
    icons: icons,
    checked: checked,
    disabled: disabled,
    key: key,
    value: value,
  )
}

pub fn basic(id: String, label: String) -> Switch {
  Switch(id, label, Neither, False, False, None, None)
}

pub fn element(
  s: Switch,
  attributes: List(Attribute(msg)),
) -> List(Element(msg)) {
  [
    element.element(
      "m3e-switch",
      append(
        [
          id(s.id),
          icon_attr(s.icons),
          boolean_attribute("checked", s.checked),
          boolean_attribute("disabled", s.disabled),
          option_attribute(s.key, fn(_) { "name" }, function.identity, None),
          option_attribute(s.value, fn(_) { "value" }, function.identity, None),
        ],
        attributes,
      ),
      [],
    ),
    label([for(s.id)], [element.text(s.label)]),
  ]
}

/// checked sets the`checked` field of a Switch
///
pub fn checked(s: Switch, c: Bool) -> Switch {
  Switch(..s, checked: c)
}

/// disabled sets the`disabled` field of a Switch
///
pub fn disabled(s: Switch, d: Bool) -> Switch {
  Switch(..s, disabled: d)
}

/// form sets up a Switch to participate in an HTML form
///
/// ## Parameters:
/// - s: a Switch
/// - key: the name of the switch when the form is submitted
/// - value: the value of the switch when the form is submitted
///
pub fn form(s: Switch, k: Option(String), v: Option(String)) -> Switch {
  Switch(..s, key: k, value: v)
}

/// icon sets the`icon` field of a Switch
///
pub fn icon(s: Switch, i: Icons) -> Switch {
  Switch(..s, icons: i)
}

fn icon_attr(i: Icons) -> Attribute(msg) {
  attribute("icons", icons_to_string(i))
}

/// key sets the`key` field of a Switch
///
pub fn key(s: Switch, key: Option(String)) -> Switch {
  Switch(..s, key: key)
}

/// value sets the`value` field of a Switch
///
pub fn value(s: Switch, value: Option(String)) -> Switch {
  Switch(..s, value: value)
}
