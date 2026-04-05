import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/chip_set.{Config}
import m3e/layout.{Vertical}

pub fn chip_set_basic_test() {
  let c = chip_set.new()
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> chip_set.render([], [])
  |> should.equal(expected)
}

pub fn chip_set_element_test() {
  let c = chip_set.new()
  let expected = element.element("m3e-chip-set", [], [])
  c
  |> chip_set.render([], [])
  |> should.equal(expected)
}

pub fn chip_set_vertical_test() {
  let c = chip_set.new() |> chip_set.vertical(Vertical)

  let expected =
    element.element("m3e-chip-set", [attribute.attribute("vertical", "")], [])
  c
  |> chip_set.render([], [])
  |> should.equal(expected)
}

pub fn chip_set_render_config_test() {
  let config = Config(vertical: Vertical)
  let expected =
    element.element("m3e-chip-set", [attribute.attribute("vertical", "")], [])

  chip_set.render_config(config, [], [])
  |> should.equal(expected)
}
