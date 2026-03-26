import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/theme.{Dark, Expressive, Light}

pub fn basic_test() {
  let t = theme.new("#ff0000")
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#ff0000"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "0"),
        attribute.attribute("motion", "standard"),
        attribute.attribute("scheme", "auto"),
      ],
      [],
    )
  theme.render(t, [], []) |> should.equal(expected)
}

pub fn element_test() {
  let t = theme.new("#ff0000")
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#ff0000"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "0"),
        attribute.attribute("motion", "standard"),
        attribute.attribute("scheme", "auto"),
      ],
      [],
    )
  t
  |> theme.render([], [])
  |> should.equal(expected)
}

pub fn color_test() {
  let t = theme.new("#abcfde")
  let t_new = theme.color(t, "#00ff00")
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#00ff00"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "0"),
        attribute.attribute("motion", "standard"),
        attribute.attribute("scheme", "auto"),
      ],
      [],
    )
  theme.render(t_new, [], []) |> should.equal(expected)
}

pub fn density_test() {
  let t = theme.new("#abcfde")
  let t_1 = theme.density(t, 1)
  let expected_1 =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#abcfde"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "1"),
        attribute.attribute("motion", "standard"),
        attribute.attribute("scheme", "auto"),
      ],
      [],
    )
  theme.render(t_1, [], []) |> should.equal(expected_1)

  let t_small = theme.density(t, theme.smallest_density - 1)
  let expected_default =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#abcfde"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "0"),
        attribute.attribute("motion", "standard"),
        attribute.attribute("scheme", "auto"),
      ],
      [],
    )
  theme.render(t_small, [], []) |> should.equal(expected_default)

  let t_large = theme.density(t, theme.largest_density + 1)
  theme.render(t_large, [], []) |> should.equal(expected_default)
}

pub fn motion_test() {
  let t = theme.new("#abcfde")
  let t_expr = theme.motion(t, Expressive)
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#abcfde"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "0"),
        attribute.attribute("motion", "expressive"),
        attribute.attribute("scheme", "auto"),
      ],
      [],
    )
  theme.render(t_expr, [], []) |> should.equal(expected)
}

pub fn scheme_test() {
  let t = theme.new("#abcfde")
  let t_dark = theme.scheme(t, Dark)
  let expected_dark =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#abcfde"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "0"),
        attribute.attribute("motion", "standard"),
        attribute.attribute("scheme", "dark"),
      ],
      [],
    )
  theme.render(t_dark, [], []) |> should.equal(expected_dark)

  let t_light = theme.scheme(t, Light)
  let expected_light =
    element.element(
      "m3e-theme",
      [
        attribute.attribute("color", "#abcfde"),
        attribute.attribute("contrast", "standard"),
        attribute.attribute("density", "0"),
        attribute.attribute("motion", "standard"),
        attribute.attribute("scheme", "light"),
      ],
      [],
    )
  theme.render(t_light, [], []) |> should.equal(expected_light)
}
// Private functions are not directly testable,
// but we can test their effects through the public API.
//
// - density_validate is tested in density_test
// - motion_to_string is tested in element.element_test via motion_attr
// - scheme_to_string is tested in element.element_test via scheme_attr
// - make_attr is tested in element.element_test
// - color_attr is tested in element.element_test
// - density_attr is tested in element.element_test
// - motion_attr is tested in element.element_test
// - scheme_attr is tested in element.element_test
