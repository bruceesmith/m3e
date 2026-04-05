import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/chip
import m3e/input_chip
import m3e/state

pub fn default_config_test() {
  let config = input_chip.default_config()

  config.disabled |> should.equal(state.default_interaction)
  config.disabled_interactive |> should.equal(state.default_interaction)
  config.removable |> should.equal(input_chip.default_removability)
  config.remove_label |> should.equal(input_chip.default_remove_label)
  config.value |> should.equal(None)
  config.variant |> should.equal(chip.default_variant)
}

pub fn render_default_test() {
  input_chip.render(input_chip.from_config(input_chip.default_config()), [], [
    element.text("Input"),
  ])
  |> should.equal(
    element.element(
      "m3e-input-chip",
      [attribute.attribute("variant", "outlined")],
      [element.text("Input")],
    ),
  )
}

pub fn render_removable_test() {
  input_chip.render(
    input_chip.removable(
      input_chip.from_config(input_chip.default_config()),
      input_chip.Removable,
    ),
    [],
    [element.text("Removable Input")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip",
      [
        attribute.attribute("removable", ""),
        attribute.attribute("remove-label", "Remove"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Removable Input")],
    ),
  )
}

pub fn render_disabled_test() {
  input_chip.render(
    input_chip.disabled(
      input_chip.from_config(input_chip.default_config()),
      state.Disabled,
    ),
    [],
    [element.text("Disabled Input")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Disabled Input")],
    ),
  )
}

pub fn render_with_value_test() {
  input_chip.render(
    input_chip.value(
      input_chip.from_config(input_chip.default_config()),
      Some("user@example.com"),
    ),
    [],
    [element.text("Email Input")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip",
      [
        attribute.attribute("value", "user@example.com"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Email Input")],
    ),
  )
}

pub fn render_with_custom_remove_label_test() {
  input_chip.render(
    input_chip.remove_label(
      input_chip.removable(
        input_chip.from_config(input_chip.default_config()),
        input_chip.Removable,
      ),
      "Delete",
    ),
    [],
    [element.text("Custom Label Input")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip",
      [
        attribute.attribute("removable", ""),
        attribute.attribute("remove-label", "Delete"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Custom Label Input")],
    ),
  )
}

pub fn render_config_test() {
  let config =
    input_chip.Config(
      disabled: state.default_interaction,
      disabled_interactive: state.default_interaction,
      removable: input_chip.Removable,
      remove_label: "Remove Item",
      value: Some("item1"),
      variant: chip.Elevated,
    )

  input_chip.render_config(config, [attribute.id("input-chip")], [
    element.text("Configured Input"),
  ])
  |> should.equal(
    element.element(
      "m3e-input-chip",
      [
        attribute.attribute("removable", ""),
        attribute.attribute("remove-label", "Remove Item"),
        attribute.attribute("value", "item1"),
        attribute.attribute("variant", "elevated"),
        attribute.id("input-chip"),
      ],
      [element.text("Configured Input")],
    ),
  )
}

pub fn slot_avatar_test() {
  input_chip.slot(input_chip.Avatar)
  |> should.equal(attribute.attribute("slot", "avatar"))
}

pub fn slot_icon_test() {
  input_chip.slot(input_chip.Icon)
  |> should.equal(attribute.attribute("slot", "icon"))
}

pub fn slot_remove_icon_test() {
  input_chip.slot(input_chip.RemoveIcon)
  |> should.equal(attribute.attribute("slot", "remove-icon"))
}
