//// Switch is an on/off control that can be toggled by clicking.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/switch_icons.{type SwitchIcons}

// --- Types ---

/// Switch is a View Model for this component
///
/// ## Fields:
///
/// - checked: Whether the element is checked.
/// - disabled: Whether the element is disabled.
/// - icons: The icons to present.
/// - name: The name that identifies the element when submitting the associated form.
/// - value: A string representing the value of the switch.
///
pub opaque type Switch {
  Switch(
    checked: Checked,
    disabled: Disabled,
    icons: SwitchIcons,
    name: String,
    value: String,
  )
}

/// Checked is whether the element is checked.
///
pub type Checked {
  IsChecked
  IsNotChecked
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

// --- Defaults ---

pub const default_checked: Checked = IsNotChecked

pub const default_disabled: Disabled = IsNotDisabled

pub const default_icons: SwitchIcons = switch_icons.None

pub const default_name: String = ""

pub const default_value: String = "on"

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    checked: Checked,
    disabled: Disabled,
    icons: SwitchIcons,
    name: String,
    value: String,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    checked: IsNotChecked,
    disabled: IsNotDisabled,
    icons: switch_icons.None,
    name: "",
    value: "on",
  )
}

// --- Constructors ---

/// from_config creates a new Switch from the given configuration.
///
pub fn from_config(config: Config) -> Switch {
  Switch(
    checked: config.checked,
    disabled: config.disabled,
    icons: config.icons,
    name: config.name,
    value: config.value,
  )
}

/// new creates a new Switch with the default configuration.
///
pub fn new() -> Switch {
  from_config(default_config())
}

// --- Setters ---

/// checked sets the value of checked for this Switch.
///
pub fn checked(record: Switch, checked: Checked) -> Switch {
  Switch(..record, checked: checked)
}

/// disabled sets the value of disabled for this Switch.
///
pub fn disabled(record: Switch, disabled: Disabled) -> Switch {
  Switch(..record, disabled: disabled)
}

/// icons sets the value of icons for this Switch.
///
pub fn icons(record: Switch, icons: SwitchIcons) -> Switch {
  Switch(..record, icons: icons)
}

/// name sets the value of name for this Switch.
///
pub fn name(record: Switch, name: String) -> Switch {
  Switch(..record, name: name)
}

/// value sets the value of value for this Switch.
///
pub fn value(record: Switch, value: String) -> Switch {
  Switch(..record, value: value)
}

// --- Renderers ---

/// render creates a Lustre Element for a Switch
///
pub fn render(
  model: Switch,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-switch",
    list.flatten([
      [
        attr.boolean("checked", model.checked == IsChecked),
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.with_default(
          "icons",
          switch_icons.to_string(model.icons),
          switch_icons.to_string(default_icons),
        ),
        attr.with_default("name", model.name, default_name),
        attr.with_default("value", model.value, default_value),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Switch Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}
