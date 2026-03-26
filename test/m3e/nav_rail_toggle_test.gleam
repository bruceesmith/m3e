import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/nav_rail_toggle

pub fn basic_test() {
  let t = nav_rail_toggle.new("my-rail")

  let expected = element.element("m3e-nav-rail-toggle", [attribute.for("my-rail")], [])

  nav_rail_toggle.render(t)
  |> should.equal(expected)
}

pub fn for_test() {
  let t =
    nav_rail_toggle.new("my-rail")
    |> nav_rail_toggle.for("other-rail")

  let expected =
    element.element("m3e-nav-rail-toggle", [attribute.for("other-rail")], [])

  nav_rail_toggle.render(t)
  |> should.equal(expected)
}
