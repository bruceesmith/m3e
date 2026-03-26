import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/shape

pub fn shape_creation_test() {
  let s = shape.new("circle")
  let expected =
    element.element("m3e-shape", [attribute.attribute("name", "circle")], [])
  shape.render(s, []) |> should.equal(expected)
}

pub fn shape_render_test() {
  let s = shape.new("square")
  let expected =
    element.element(
      "m3e-shape",
      [
        attribute.attribute("name", "square"),
        attribute.attribute("class", "extra"),
      ],
      [],
    )
  shape.render(s, [attribute.attribute("class", "extra")])
  |> should.equal(expected)
}

pub fn shape_setters_test() {
  let s = shape.new("circle") |> shape.name("triangle")
  let expected =
    element.element("m3e-shape", [attribute.attribute("name", "triangle")], [])
  shape.render(s, []) |> should.equal(expected)
}
