import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/shape.{name, new, render}

pub fn shape_creation_test() {
  let s = new("circle")
  let expected = element("m3e-shape", [attribute("name", "circle")], [])
  render(s, []) |> should.equal(expected)
}

pub fn shape_render_test() {
  let s = new("square")
  let expected =
    element(
      "m3e-shape",
      [attribute("name", "square"), attribute("class", "extra")],
      [],
    )
  render(s, [attribute("class", "extra")])
  |> should.equal(expected)
}

pub fn shape_setters_test() {
  let s = new("circle") |> name("triangle")
  let expected = element("m3e-shape", [attribute("name", "triangle")], [])
  render(s, []) |> should.equal(expected)
}
