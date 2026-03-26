import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/divider.{Both, End, Start, inset, new, render, vertical}
import m3e/layout.{Vertical}

pub fn divider_basic_test() {
  let d = new()
  let expected = element.element("m3e-divider", [], [])
  d
  |> render([])
  |> should.equal(expected)
}

pub fn divider_element_test() {
  let d = new()
  let expected = element.element("m3e-divider", [], [])
  d
  |> render([])
  |> should.equal(expected)
}

pub fn divider_inset_test() {
  let d = new() |> inset(Some(Both))

  let expected = element.element("m3e-divider", [attribute.attribute("inset", "")], [])
  d
  |> render([])
  |> should.equal(expected)

  let d = d |> inset(Some(Start))
  let expected = element.element("m3e-divider", [attribute.attribute("inset-start", "")], [])
  d
  |> render([])
  |> should.equal(expected)

  let d = d |> inset(Some(End))
  let expected = element.element("m3e-divider", [attribute.attribute("inset-end", "")], [])
  d
  |> render([])
  |> should.equal(expected)
}

pub fn divider_vertical_test() {
  let d = new() |> vertical(Vertical)

  let expected = element.element("m3e-divider", [attribute.attribute("vertical", "")], [])
  d
  |> render([])
  |> should.equal(expected)
}
