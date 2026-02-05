import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import m3e/theme.{
  Dark, Expressive, Light, basic, color, density, largest_density, motion,
  scheme, smallest_density,
}

pub fn basic_test() {
  let t = basic("#ff0000")
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#ff0000"),
        attribute("contrast", "standard"),
        attribute("density", "0"),
        attribute("motion", "standard"),
        attribute("scheme", "auto"),
      ],
      [],
    )
  theme.element(t, [], []) |> should.equal(expected)
}

pub fn element_test() {
  let t = basic("#ff0000")
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#ff0000"),
        attribute("contrast", "standard"),
        attribute("density", "0"),
        attribute("motion", "standard"),
        attribute("scheme", "auto"),
      ],
      [],
    )
  t
  |> theme.element([], [])
  |> should.equal(expected)
}

pub fn color_test() {
  let t = basic("#abcfde")
  let t_new = color(t, "#00ff00")
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#00ff00"),
        attribute("contrast", "standard"),
        attribute("density", "0"),
        attribute("motion", "standard"),
        attribute("scheme", "auto"),
      ],
      [],
    )
  theme.element(t_new, [], []) |> should.equal(expected)
}

pub fn density_test() {
  let t = basic("#abcfde")
  let t_1 = density(t, 1)
  let expected_1 =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#abcfde"),
        attribute("contrast", "standard"),
        attribute("density", "1"),
        attribute("motion", "standard"),
        attribute("scheme", "auto"),
      ],
      [],
    )
  theme.element(t_1, [], []) |> should.equal(expected_1)

  let t_small = density(t, smallest_density - 1)
  let expected_default =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#abcfde"),
        attribute("contrast", "standard"),
        attribute("density", "0"),
        attribute("motion", "standard"),
        attribute("scheme", "auto"),
      ],
      [],
    )
  theme.element(t_small, [], []) |> should.equal(expected_default)

  let t_large = density(t, largest_density + 1)
  theme.element(t_large, [], []) |> should.equal(expected_default)
}

pub fn motion_test() {
  let t = basic("#abcfde")
  let t_expr = motion(t, Expressive)
  let expected =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#abcfde"),
        attribute("contrast", "standard"),
        attribute("density", "0"),
        attribute("motion", "expressive"),
        attribute("scheme", "auto"),
      ],
      [],
    )
  theme.element(t_expr, [], []) |> should.equal(expected)
}

pub fn scheme_test() {
  let t = basic("#abcfde")
  let t_dark = scheme(t, Dark)
  let expected_dark =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#abcfde"),
        attribute("contrast", "standard"),
        attribute("density", "0"),
        attribute("motion", "standard"),
        attribute("scheme", "dark"),
      ],
      [],
    )
  theme.element(t_dark, [], []) |> should.equal(expected_dark)

  let t_light = scheme(t, Light)
  let expected_light =
    element.element(
      "m3e-theme",
      [
        attribute("color", "#abcfde"),
        attribute("contrast", "standard"),
        attribute("density", "0"),
        attribute("motion", "standard"),
        attribute("scheme", "light"),
      ],
      [],
    )
  theme.element(t_light, [], []) |> should.equal(expected_light)
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
