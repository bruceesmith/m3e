import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/nav_rail

pub fn basic_test() {
  let r = nav_rail.new()

  let expected =
    element.element("m3e-nav-rail", [attribute.attribute("mode", "auto")], [])

  nav_rail.render(r, [], [])
  |> should.equal(expected)
}

pub fn mode_test() {
  let r =
    nav_rail.new()
    |> nav_rail.mode(nav_rail.Compact)

  let expected =
    element.element(
      "m3e-nav-rail",
      [attribute.attribute("mode", "compact")],
      [],
    )

  nav_rail.render(r, [], [])
  |> should.equal(expected)

  let r2 =
    nav_rail.new()
    |> nav_rail.mode(nav_rail.Expanded)

  let expected2 =
    element.element(
      "m3e-nav-rail",
      [attribute.attribute("mode", "expanded")],
      [],
    )

  nav_rail.render(r2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let r = nav_rail.new()
  let child = element.element("div", [], [])

  let expected =
    element.element("m3e-nav-rail", [attribute.attribute("mode", "auto")], [
      child,
    ])

  nav_rail.render(r, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let r = nav_rail.new()
  let attr = attribute.attribute("class", "custom")

  let expected =
    element.element(
      "m3e-nav-rail",
      [attribute.attribute("mode", "auto"), attr],
      [],
    )

  nav_rail.render(r, [attr], [])
  |> should.equal(expected)
}
