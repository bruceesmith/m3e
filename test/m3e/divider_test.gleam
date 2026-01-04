import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import m3e/divider.{Both, End, Start, divider, element, inset, vertical}

pub fn divider_basic_test() {
  let d = divider(None, False)
  d.inset |> should.equal(None)
  d.vertical |> should.be_false()
}

pub fn divider_element_test() {
  let d = divider(None, False)
  let expected = element.element("m3e-divider", [], [])
  d
  |> element()
  |> should.equal(expected)
}

pub fn divider_inset_test() {
  let d = divider(None, False) |> inset(Some(Both))
  d.inset |> should.equal(Some(Both))

  let expected =
    element.element("m3e-divider", [attribute("inset", "")], [])
  d
  |> element()
  |> should.equal(expected)

  let d = d |> inset(Some(Start))
  let expected =
    element.element("m3e-divider", [attribute("inset-start", "")], [])
  d
  |> element()
  |> should.equal(expected)

  let d = d |> inset(Some(End))
  let expected =
    element.element("m3e-divider", [attribute("inset-end", "")], [])
  d
  |> element()
  |> should.equal(expected)
}

pub fn divider_vertical_test() {
  let d = divider(None, False) |> vertical(True)
  d.vertical |> should.be_true()

  let expected =
    element.element("m3e-divider", [attribute("vertical", "")], [])
  d
  |> element()
  |> should.equal(expected)
}
