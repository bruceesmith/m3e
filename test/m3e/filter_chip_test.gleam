import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/chip
import m3e/filter_chip
import m3e/state

pub fn default_config_test() {
  let config = filter_chip.default_config()

  config.disabled |> should.equal(state.default_interaction)
  config.disabled_interactive |> should.equal(state.default_interaction)
  config.selected |> should.equal(state.default_selection_state)
  config.value |> should.equal("")
  config.variant |> should.equal(chip.default_variant)
}

pub fn render_default_test() {
  filter_chip.render(filter_chip.from_config(filter_chip.default_config()), [], [
    element.text("Filter"),
  ])
  |> should.equal(
    element.element(
      "m3e-filter-chip",
      [
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Filter")],
    ),
  )
}

pub fn render_selected_test() {
  filter_chip.render(
    filter_chip.selected(
      filter_chip.from_config(filter_chip.default_config()),
      state.Selected,
    ),
    [],
    [element.text("Selected Filter")],
  )
  |> should.equal(
    element.element(
      "m3e-filter-chip",
      [
        attribute.attribute("selected", ""),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Selected Filter")],
    ),
  )
}

pub fn render_disabled_test() {
  filter_chip.render(
    filter_chip.disabled(
      filter_chip.from_config(filter_chip.default_config()),
      state.Disabled,
    ),
    [],
    [element.text("Disabled Filter")],
  )
  |> should.equal(
    element.element(
      "m3e-filter-chip",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Disabled Filter")],
    ),
  )
}

pub fn render_with_value_test() {
  filter_chip.render(
    filter_chip.value(
      filter_chip.from_config(filter_chip.default_config()),
      "category:tech",
    ),
    [],
    [element.text("Tech Filter")],
  )
  |> should.equal(
    element.element(
      "m3e-filter-chip",
      [
        attribute.attribute("value", "category:tech"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Tech Filter")],
    ),
  )
}

pub fn render_config_test() {
  let config =
    filter_chip.Config(
      disabled: state.default_interaction,
      disabled_interactive: state.default_interaction,
      selected: state.Selected,
      value: "active",
      variant: chip.Elevated,
    )

  filter_chip.render_config(config, [attribute.id("filter-chip")], [
    element.text("Configured Filter"),
  ])
  |> should.equal(
    element.element(
      "m3e-filter-chip",
      [
        attribute.attribute("selected", ""),
        attribute.attribute("value", "active"),
        attribute.attribute("variant", "elevated"),
        attribute.id("filter-chip"),
      ],
      [element.text("Configured Filter")],
    ),
  )
}

pub fn slot_icon_test() {
  filter_chip.slot(filter_chip.Icon)
  |> should.equal(attribute.attribute("slot", "icon"))
}

pub fn slot_trailing_icon_test() {
  filter_chip.slot(filter_chip.TrailingIcon)
  |> should.equal(attribute.attribute("slot", "trailing-icon"))
}
