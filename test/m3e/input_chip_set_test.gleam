import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/input_chip_set
import m3e/layout
import m3e/state

pub fn default_config_test() {
  let config = input_chip_set.default_config()

  config.disabled |> should.equal(state.default_interaction)
  config.name |> should.equal(None)
  config.required |> should.equal(state.default_requirement)
  config.vertical |> should.equal(layout.default_orientation)
}

pub fn render_default_test() {
  input_chip_set.render(input_chip_set.new(), [], [
    element.text("Input Chip Set"),
  ])
  |> should.equal(
    element.element("m3e-input-chip-set", [], [element.text("Input Chip Set")]),
  )
}

pub fn render_disabled_test() {
  input_chip_set.render(
    input_chip_set.disabled(input_chip_set.new(), state.Disabled),
    [],
    [element.text("Disabled Input Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip-set",
      [attribute.attribute("disabled", "")],
      [element.text("Disabled Input Chip Set")],
    ),
  )
}

pub fn render_required_test() {
  input_chip_set.render(
    input_chip_set.required(input_chip_set.new(), state.Required),
    [],
    [element.text("Required Input Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip-set",
      [attribute.attribute("required", "")],
      [element.text("Required Input Chip Set")],
    ),
  )
}

pub fn render_vertical_test() {
  input_chip_set.render(
    input_chip_set.vertical(input_chip_set.new(), layout.Vertical),
    [],
    [element.text("Vertical Input Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip-set",
      [attribute.attribute("vertical", "")],
      [element.text("Vertical Input Chip Set")],
    ),
  )
}

pub fn render_with_name_test() {
  input_chip_set.render(
    input_chip_set.name(input_chip_set.new(), Some("input-group")),
    [],
    [element.text("Named Input Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-input-chip-set",
      [attribute.attribute("name", "input-group")],
      [element.text("Named Input Chip Set")],
    ),
  )
}

pub fn render_config_test() {
  let config =
    input_chip_set.Config(
      disabled: state.Disabled,
      name: Some("test-inputs"),
      required: state.Required,
      vertical: layout.Vertical,
    )

  input_chip_set.render_config(config, [attribute.id("input-chip-set")], [
    element.text("Configured Input Chip Set"),
  ])
  |> should.equal(
    element.element(
      "m3e-input-chip-set",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("name", "test-inputs"),
        attribute.attribute("required", ""),
        attribute.attribute("vertical", ""),
        attribute.id("input-chip-set"),
      ],
      [element.text("Configured Input Chip Set")],
    ),
  )
}

pub fn slot_test() {
  input_chip_set.slot(input_chip_set.Input)
  |> should.equal(attribute.attribute("slot", "input"))
}
