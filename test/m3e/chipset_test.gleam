import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import m3e/chipset.{
  Filter, Information, Input, chipset, disabled, hide_selection_indicator, multi,
  render, vertical,
}

pub fn chipset_basic_test() {
  let c = chipset(Information)
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)
}

pub fn chipset_element_test() {
  let c = chipset(Information)
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)

  let c = chipset(Filter)
  let expected = element.element("m3e-filter-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)

  let c = chipset(Input)
  let expected = element.element("m3e-input-chip-set", [], [])
  c
  |> render([], [])
  |> should.equal(expected)
}

pub fn chipset_disabled_test() {
  let c = chipset(Input) |> disabled(True)

  let expected =
    element.element("m3e-input-chip-set", [attribute("disabled", "")], [])
  c
  |> render([], [])
  |> should.equal(expected)

  // Disabling a non-Input chipset should have no effect
  let c_info = chipset(Information) |> disabled(True)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_hide_selection_indicator_test() {
  let c = chipset(Filter) |> hide_selection_indicator(True)

  let expected =
    element.element(
      "m3e-filter-chip-set",
      [attribute("hide-selection-indicator", "")],
      [],
    )
  c
  |> render([], [])
  |> should.equal(expected)

  // Hiding selection indicator on a non-Filter chipset should have no effect
  let c_info =
    chipset(Information)
    |> hide_selection_indicator(True)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_multi_test() {
  let c = chipset(Filter) |> multi(True)

  let expected =
    element.element("m3e-filter-chip-set", [attribute("multi", "")], [])
  c
  |> render([], [])
  |> should.equal(expected)

  // Setting multi on a non-Filter chipset should have no effect
  let c_info = chipset(Information) |> multi(True)
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> render([], [])
  |> should.equal(expected_info)
}

pub fn chipset_vertical_test() {
  let c = chipset(Information) |> vertical(True)

  let expected =
    element.element("m3e-chip-set", [attribute("vertical", "")], [])
  c
  |> render([], [])
  |> should.equal(expected)
}
