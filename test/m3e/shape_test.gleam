import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/shape.{name, new, render}

pub fn shape_creation_test() {
  let s = new("circle")
  let expected = element.element("m3e-shape", [attribute.attribute("name", "circle")], [])
  render(s, []) |> should.equal(expected)
}

pub fn shape_render_test() {
  let s = new("square")
  let expected =
    element.element(
      "m3e-shape",
      [attribute.attribute("name", "square"), attribute.attribute("class", "extra")],
      [],
    )
  render(s, [attribute.attribute("class", "extra")])
  |> should.equal(expected)
}

pub fn shape_setters_test() {
  let s = new("circle") |> name("triangle")
  let expected = element.element("m3e-shape", [attribute.attribute("name", "triangle")], [])
  render(s, []) |> should.equal(expected)
}
