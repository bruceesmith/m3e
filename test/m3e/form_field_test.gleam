import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html.{text}
import m3e/form_field.{
  Always, AlwaysHide, Filled, NeverHide, basic, element, float_label, form_field,
  hide_required_marker, hide_subscript, variant,
}

pub fn form_field_creation_test() {
  let f = basic()
  let expected =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-subscript", "auto"),
        attribute("variant", "outlined"),
      ],
      [],
    )
  element(f, [], []) |> should.equal(expected)

  let f = form_field(Always, True, NeverHide, Filled)
  let expected =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "always"),
        attribute("hide-required-marker", ""),
        attribute("hide-subscript", "never"),
        attribute("variant", "filled"),
      ],
      [],
    )
  element(f, [], []) |> should.equal(expected)
}

pub fn form_field_element_test() {
  let f = basic()
  let expected =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-subscript", "auto"),
        attribute("variant", "outlined"),
      ],
      [text("Child")],
    )
  f |> element([], [text("Child")]) |> should.equal(expected)

  let f = form_field(Always, True, AlwaysHide, Filled)
  let expected =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "always"),
        attribute("hide-required-marker", ""),
        attribute("hide-subscript", "always"),
        attribute("variant", "filled"),
      ],
      [text("Child")],
    )
  f |> element([], [text("Child")]) |> should.equal(expected)
}

pub fn form_field_setters_test() {
  let f = basic()

  let f_float = f |> float_label(Always)
  let expected_float =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "always"),
        attribute("hide-subscript", "auto"),
        attribute("variant", "outlined"),
      ],
      [],
    )
  element(f_float, [], []) |> should.equal(expected_float)

  let f_marker = f |> hide_required_marker(True)
  let expected_marker =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-required-marker", ""),
        attribute("hide-subscript", "auto"),
        attribute("variant", "outlined"),
      ],
      [],
    )
  element(f_marker, [], []) |> should.equal(expected_marker)

  let f_sub = f |> hide_subscript(NeverHide)
  let expected_sub =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-subscript", "never"),
        attribute("variant", "outlined"),
      ],
      [],
    )
  element(f_sub, [], []) |> should.equal(expected_sub)

  let f_var = f |> variant(Filled)
  let expected_var =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-subscript", "auto"),
        attribute("variant", "filled"),
      ],
      [],
    )
  element(f_var, [], []) |> should.equal(expected_var)
}
