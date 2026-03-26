import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/divider.{Both, End, Start}
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

pub fn divider_vertical_test() {
  let d = divider.new() |> divider.vertical(Vertical)

  let expected =
    element.element("m3e-divider", [attribute.attribute("vertical", "")], [])
  d
  |> divider.render([])
  |> should.equal(expected)
}
