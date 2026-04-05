import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/config
import m3e/filter_chip_set
import m3e/layout
import m3e/state

pub fn default_config_test() {
  let config = filter_chip_set.default_config()

  config.disabled |> should.equal(state.default_interaction)
  config.hide_selection_indicator
  |> should.equal(config.default_selection_indicator)
  config.multi |> should.equal(config.default_selection_mode)
  config.name |> should.equal(None)
  config.vertical |> should.equal(layout.default_orientation)
}

pub fn render_default_test() {
  filter_chip_set.render(filter_chip_set.new(), [], [
    element.text("Filter Chip Set"),
  ])
  |> should.equal(
    element.element("m3e-filter-chip-set", [], [element.text("Filter Chip Set")]),
  )
}

pub fn render_disabled_test() {
  filter_chip_set.render(
    filter_chip_set.disabled(filter_chip_set.new(), state.Disabled),
    [],
    [element.text("Disabled Filter Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("disabled", "")],
      [element.text("Disabled Filter Chip Set")],
    ),
  )
}

pub fn render_multi_test() {
  filter_chip_set.render(
    filter_chip_set.multi(filter_chip_set.new(), config.Multi),
    [],
    [element.text("Multi Filter Chip Set")],
  )
  |> should.equal(
    element.element("m3e-filter-chip-set", [attribute.attribute("multi", "")], [
      element.text("Multi Filter Chip Set"),
    ]),
  )
}

pub fn render_vertical_test() {
  filter_chip_set.render(
    filter_chip_set.vertical(filter_chip_set.new(), layout.Vertical),
    [],
    [element.text("Vertical Filter Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("vertical", "")],
      [element.text("Vertical Filter Chip Set")],
    ),
  )
}

pub fn render_hide_selection_indicator_test() {
  filter_chip_set.render(
    filter_chip_set.hide_selection_indicator(
      filter_chip_set.new(),
      config.HideSelectionIndicator,
    ),
    [],
    [element.text("Hidden Indicator Filter Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("hide-selection-indicator", "")],
      [element.text("Hidden Indicator Filter Chip Set")],
    ),
  )
}

pub fn render_with_name_test() {
  filter_chip_set.render(
    filter_chip_set.name(filter_chip_set.new(), Some("filter-group")),
    [],
    [element.text("Named Filter Chip Set")],
  )
  |> should.equal(
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("name", "filter-group")],
      [element.text("Named Filter Chip Set")],
    ),
  )
}

pub fn render_config_test() {
  let config =
    filter_chip_set.Config(
      disabled: state.Disabled,
      hide_selection_indicator: config.HideSelectionIndicator,
      multi: config.Multi,
      name: Some("test-filters"),
      vertical: layout.Vertical,
    )

  filter_chip_set.render_config(config, [attribute.id("filter-chip-set")], [
    element.text("Configured Filter Chip Set"),
  ])
  |> should.equal(
    element.element(
      "m3e-filter-chip-set",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("multi", ""),
        attribute.attribute("name", "test-filters"),
        attribute.attribute("vertical", ""),
        attribute.id("filter-chip-set"),
      ],
      [element.text("Configured Filter Chip Set")],
    ),
  )
}
