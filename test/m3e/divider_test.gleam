import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/divider.{Both, End, Indented, NotIndented, Start}
import m3e/layout.{Vertical}

pub fn divider_basic_test() {
  let d = divider.new()
  let expected = element.element("m3e-divider", [], [])
  d
  |> divider.render([])
  |> should.equal(expected)
}

pub fn divider_element_test() {
  let d = divider.new()
  let expected = element.element("m3e-divider", [], [])
  d
  |> divider.render([])
  |> should.equal(expected)
}

pub fn divider_inset_test() {
  let d = divider.new() |> divider.inset(Some(Both))

  let expected =
    element.element("m3e-divider", [attribute.attribute("inset", "")], [])
  d
  |> divider.render([])
  |> should.equal(expected)

  let d = d |> divider.inset(Some(Start))
  let expected =
    element.element("m3e-divider", [attribute.attribute("inset-start", "")], [])
  d
  |> divider.render([])
  |> should.equal(expected)

  let d = d |> divider.inset(Some(End))
  let expected =
    element.element("m3e-divider", [attribute.attribute("inset-end", "")], [])
  d
  |> divider.render([])
  |> should.equal(expected)
}

pub fn divider_indentation_test() {
  // Test inset_start
  let d = divider.new() |> divider.inset_start(Indented)
  let expected =
    element.element("m3e-divider", [attribute.attribute("inset-start", "")], [])
  d |> divider.render([]) |> should.equal(expected)

  // Test inset_end
  let d = divider.new() |> divider.inset_end(Indented)
  let expected =
    element.element("m3e-divider", [attribute.attribute("inset-end", "")], [])
  d |> divider.render([]) |> should.equal(expected)

  // Test both
  let d =
    divider.new()
    |> divider.inset_start(Indented)
    |> divider.inset_end(Indented)
  let expected =
    element.element(
      "m3e-divider",
      [
        attribute.attribute("inset-start", ""),
        attribute.attribute("inset-end", ""),
      ],
      [],
    )
  d |> divider.render([]) |> should.equal(expected)

  // Test resetting (edge case)
  let d =
    divider.new()
    |> divider.inset_start(Indented)
    |> divider.inset_start(NotIndented)
  let expected = element.element("m3e-divider", [], [])
  d |> divider.render([]) |> should.equal(expected)
}

pub fn divider_vertical_test() {
  let d = divider.new() |> divider.vertical(Vertical)

  let expected =
    element.element("m3e-divider", [attribute.attribute("vertical", "")], [])
  d
  |> divider.render([])
  |> should.equal(expected)
}
