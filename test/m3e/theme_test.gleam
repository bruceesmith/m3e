import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import m3e/theme.{
  Auto, Dark, Expressive, Light, Standard, basic, color, default_density,
  density, largest_density, motion, scheme, smallest_density,
}

pub fn basic_test() {
  let t = basic("#ff0000")
  t.color
  |> should.equal("#ff0000")
  t.density
  |> should.equal(default_density)
  t.motion
  |> should.equal(Standard)
  t.scheme
  |> should.equal(Auto)

  let t = basic("#ff0000")
  t.color
  |> should.equal("#ff0000")
}

pub fn element_test() {
  let t = basic("#ff0000")
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#ff0000"),
        attribute("density", "0"),
        attribute("motion", "standard"),
        attribute("scheme", "auto"),
      ],
      [],
    )
  t
  |> theme.element([])
  |> should.equal(expected)
}

pub fn color_test() {
  let t = basic("#abcfde")
  let t = color(t, "#00ff00")
  t.color
  |> should.equal("#00ff00")
}

pub fn density_test() {
  let t = basic("#abcfde")
  let t = density(t, 1)
  t.density
  |> should.equal(1)

  let t = density(t, smallest_density - 1)
  t.density
  |> should.equal(default_density)

  let t = density(t, largest_density + 1)
  t.density
  |> should.equal(default_density)
}

pub fn motion_test() {
  let t = basic("#abcfde")
  let t = motion(t, Expressive)
  t.motion
  |> should.equal(Expressive)
}

pub fn scheme_test() {
  let t = basic("#abcfde")
  let t = scheme(t, Dark)
  t.scheme
  |> should.equal(Dark)
  let t = scheme(t, Light)
  t.scheme
  |> should.equal(Light)
}
// Private functions are not directly testable,
// but we can test their effects through the public API.
//
// - density_validate is tested in density_test
// - motion_to_string is tested in element_test via motion_attr
// - scheme_to_string is tested in element_test via scheme_attr
// - make_attr is tested in element_test
// - color_attr is tested in element_test
// - density_attr is tested in element_test
// - motion_attr is tested in element_test
// - scheme_attr is tested in element_test
