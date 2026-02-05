//// switch provides Lustre support for the [M3E Switch component](https://matraic.github.io/m3e/#/components/switch.html)

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}
import lustre/element/html.{text}
import m3e/helpers.{boolean_attribute}

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

pub opaque type Switch {
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
  Switch(
    id: id,
    label: label,
    icons: Neither,
    checked: False,
    disabled: False,
    key: None,
    value: None,
  )
}

pub fn checked(s: Switch, checked: Bool) -> Switch {
  Switch(..s, checked: checked)
}

pub fn disabled(s: Switch, disabled: Bool) -> Switch {
  Switch(..s, disabled: disabled)
}

pub fn element(
  s: Switch,
  attributes: List(Attribute(msg)),
) -> List(Element(msg)) {
  [
    element.element(
      "m3e-switch",
      list.append(
        [
          attribute.id(s.id),
          attribute("icons", icons_to_string(s.icons)),
          boolean_attribute("checked", s.checked),
          boolean_attribute("disabled", s.disabled),
          case s.key {
            Some(k) -> attribute.name(k)
            None -> none()
          },
          case s.value {
            Some(v) -> attribute.value(v)
            None -> none()
          },
        ],
        attributes,
      )
        |> list.filter(fn(a) { a != none() }),
      [],
    ),
    element.element("label", [attribute.for(s.id)], [text(s.label)]),
  ]
}

pub fn form(s: Switch, key: Option(String), value: Option(String)) -> Switch {
  Switch(..s, key: key, value: value)
}

pub fn icon(s: Switch, icons: Icons) -> Switch {
  Switch(..s, icons: icons)
}

pub fn key(s: Switch, key: Option(String)) -> Switch {
  Switch(..s, key: key)
}

pub fn value(s: Switch, value: Option(String)) -> Switch {
  Switch(..s, value: value)
}
