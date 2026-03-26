import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/chipset.{Config, Filter, Input}
import m3e/config.{HideSelectionIndicator, Multi}
import m3e/layout.{Vertical}
import m3e/state.{Disabled}

pub fn chipset_basic_test() {
  let c = chipset.new()
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> chipset.render([], [])
  |> should.equal(expected)
}

pub fn chipset_element_test() {
  let c = chipset.new()
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> chipset.render([], [])
  |> should.equal(expected)

  let c = chipset.new() |> chipset.type_(Filter)
  let expected = element.element("m3e-filter-chip-set", [], [])
  c
  |> chipset.render([], [])
  |> should.equal(expected)

  let c = chipset.new() |> chipset.type_(Input)
  let expected = element.element("m3e-input-chip-set", [], [])
  c
  |> chipset.render([], [])
  |> should.equal(expected)
}

pub fn chipset_disabled_test() {
  let c = chipset.new() |> chipset.type_(Input) |> chipset.disabled(Disabled)

  let expected =
    element.element(
      "m3e-input-chip-set",
      [attribute.attribute("disabled", "")],
      [],
    )
  c
  |> chipset.render([], [])
  |> should.equal(expected)

  // Disabling a non-Input chipset should have no effect
  let c_info = chipset.new() |> chipset.disabled(Disabled)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> chipset.render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_hide_selection_indicator_test() {
  let c =
    chipset.new()
    |> chipset.type_(Filter)
    |> chipset.hide_selection_indicator(HideSelectionIndicator)

  let expected =
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("hide-selection-indicator", "")],
      [],
    )
  c
  |> chipset.render([], [])
  |> should.equal(expected)

  // Hiding selection indicator on a non-Filter chipset should have no effect
  let c_info =
    chipset.new()
    |> chipset.hide_selection_indicator(HideSelectionIndicator)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> chipset.render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_multi_test() {
  let c = chipset.new() |> chipset.type_(Filter) |> chipset.multi(Multi)

  let expected =
    element.element(
      "m3e-filter-chip-set",
      [attribute.attribute("multi", "")],
      [],
    )
  c
  |> chipset.render([], [])
  |> should.equal(expected)

  // Setting multi on a non-Filter chipset should have no effect
  let c_info = chipset.new() |> chipset.multi(Multi)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> chipset.render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_vertical_test() {
  let c = chipset.new() |> chipset.vertical(Vertical)

  let expected =
    element.element("m3e-chip-set", [attribute.attribute("vertical", "")], [])
  c
  |> chipset.render([], [])
  |> should.equal(expected)
}

pub fn chipset_render_config_test() {
  let config =
    Config(
      ..chipset.default_config(),
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

  chipset.render_config(config, [], [])
  |> should.equal(expected)
}
