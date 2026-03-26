import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/chipset.{
  Config, Filter, Input, default_config, disabled, hide_selection_indicator,
  multi, new, render, render_config, type_, vertical,
}
import m3e/config.{HideSelectionIndicator, Multi}
import m3e/layout.{Vertical}
import m3e/state.{Disabled}

pub fn chipset_basic_test() {
  let c = new()
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)
}

pub fn chipset_element_test() {
  let c = new()
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)

  let c = new() |> type_(Filter)
  let expected = element.element("m3e-filter-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)

  let c = new() |> type_(Input)
  let expected = element.element("m3e-input-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)
}

pub fn chipset_disabled_test() {
  let c = new() |> type_(Input) |> disabled(Disabled)

  let expected = element.element("m3e-input-chip-set", [attribute.attribute("disabled", "")], [])
  c
  |> render([], [])
  |> should.equal(expected)

  // Disabling a non-Input chipset should have no effect
  let c_info = new() |> disabled(Disabled)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_hide_selection_indicator_test() {
  let c =
    new() |> type_(Filter) |> hide_selection_indicator(HideSelectionIndicator)

  let expected =
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("hide-selection-indicator", "")],
      [],
    )
  c
  |> render([], [])
  |> should.equal(expected)

  // Hiding selection indicator on a non-Filter chipset should have no effect
  let c_info =
    new()
    |> hide_selection_indicator(HideSelectionIndicator)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_multi_test() {
  let c = new() |> type_(Filter) |> multi(Multi)

  let expected = element.element("m3e-filter-chip-set", [attribute.attribute("multi", "")], [])
  c
  |> render([], [])
  |> should.equal(expected)

  // Setting multi on a non-Filter chipset should have no effect
  let c_info = new() |> multi(Multi)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_vertical_test() {
  let c = new() |> vertical(Vertical)

  let expected = element.element("m3e-chip-set", [attribute.attribute("vertical", "")], [])
  c
  |> render([], [])
  |> should.equal(expected)
}

pub fn chipset_render_config_test() {
  let config =
    Config(
      ..default_config(),
      type_: Filter,
      selection_mode: Multi,
      orientation: Vertical,
    )
  let expected =
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("multi", ""), attribute.attribute("vertical", "")],
      [],
    )

  render_config(config, [], [])
  |> should.equal(expected)
}
