import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/divider.{Both, End, Start, inset, new, render, vertical}

pub fn divider_basic_test() {
  let d = new(None, False)
  let expected = element("m3e-divider", [], [])
  d
  |> render()
  |> should.equal(expected)
}

pub fn divider_element_test() {
  let d = new(None, False)
  let expected = element("m3e-divider", [], [])
  d
  |> render()
  |> should.equal(expected)
}

pub fn divider_inset_test() {
  let d = new(None, False) |> inset(Some(Both))

  let expected = element("m3e-divider", [attribute("inset", "")], [])
  d
  |> render()
  |> should.equal(expected)

  let d = d |> inset(Some(Start))
  let expected = element("m3e-divider", [attribute("inset-start", "")], [])
  d
  |> render()
  |> should.equal(expected)

  let d = d |> inset(Some(End))
  let expected = element("m3e-divider", [attribute("inset-end", "")], [])
  d
  |> render()
  |> should.equal(expected)
}

pub fn divider_vertical_test() {
  let d = new(None, False) |> vertical(True)

  let expected = element("m3e-divider", [attribute("vertical", "")], [])
  d
  |> render()
  |> should.equal(expected)
}
