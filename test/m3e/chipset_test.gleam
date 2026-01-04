import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import m3e/chipset.{
  Filter, Information, Input, chipset, disabled, element,
  hide_selection_indicator, multi, vertical,
}

pub fn chipset_basic_test() {
  let c = chipset(Information)
  c.disabled |> should.be_false()
  c.hide_selection_indicator |> should.be_false()
  c.multi |> should.be_false()
  c.type_ |> should.equal(Information)
  c.vertical |> should.be_false()
}

pub fn chipset_element_test() {
  let c = chipset(Information)
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> element([], [])
  |> should.equal(expected)

  let c = chipset(Filter)
  let expected = element.element("m3e-filter-chip-set", [], [])
  c
  |> element([], [])
  |> should.equal(expected)

  let c = chipset(Input)
  let expected = element.element("m3e-input-chip-set", [], [])
  c
  |> element([], [])
  |> should.equal(expected)
}

pub fn chipset_disabled_test() {
  let c = chipset(Input) |> disabled(True)
  c.disabled |> should.be_true()

  let expected =
    element.element("m3e-input-chip-set", [attribute("disabled", "")], [])
  c
  |> element([], [])
  |> should.equal(expected)

  // Disabling a non-Input chipset should have no effect
  let c_info = chipset(Information) |> disabled(True)
  c_info.disabled |> should.be_false()
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> element([], [])
  |> should.equal(expected_info)
}

pub fn chipset_hide_selection_indicator_test() {
  let c = chipset(Filter) |> hide_selection_indicator(True)
  c.hide_selection_indicator |> should.be_true()

  let expected =
    element.element(
      "m3e-filter-chip-set",
      [attribute("hide-selection-indicator", "")],
      [],
    )
  c
  |> element([], [])
  |> should.equal(expected)

  // Hiding selection indicator on a non-Filter chipset should have no effect
  let c_info =
    chipset(Information)
    |> hide_selection_indicator(True)
  c_info.hide_selection_indicator |> should.be_false()
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> element([], [])
  |> should.equal(expected_info)
}

pub fn chipset_multi_test() {
  let c = chipset(Filter) |> multi(True)
  c.multi |> should.be_true()

  let expected =
    element.element("m3e-filter-chip-set", [attribute("multi", "")], [])
  c
  |> element([], [])
  |> should.equal(expected)

  // Setting multi on a non-Filter chipset should have no effect
  let c_info = chipset(Information) |> multi(True)
  c_info.multi |> should.be_false()
  let expected_info = element.element("m3e-chip-set", [], [])
  c_info
  |> element([], [])
  |> should.equal(expected_info)
}

pub fn chipset_vertical_test() {
  let c = chipset(Information) |> vertical(True)
  c.vertical |> should.be_true()

  let expected =
    element.element("m3e-chip-set", [attribute("vertical", "")], [])
  c
  |> element([], [])
  |> should.equal(expected)
}
