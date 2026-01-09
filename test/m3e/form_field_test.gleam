import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html.{text}
import m3e/form_field.{
  Always, AlwaysHide, Filled, NeverHide, basic, default_float_label,
  default_hide_subscript, default_variant, element, float_label, form_field,
  hide_required_marker, hide_subscript, variant,
}

pub fn form_field_creation_test() {
  let f = basic()
  f.float_label |> should.equal(default_float_label)
  f.hide_required_marker |> should.be_false()
  f.hide_subscript |> should.equal(default_hide_subscript)
  f.variant |> should.equal(default_variant)

  let f = form_field(Always, True, NeverHide, Filled)
  f.float_label |> should.equal(Always)
  f.hide_required_marker |> should.be_true()
  f.hide_subscript |> should.equal(NeverHide)
  f.variant |> should.equal(Filled)
}

pub fn form_field_element_test() {
  let f = basic()
  let expected =
    element.element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute.none(),
        attribute("hide-subscript", "auto"),
        attribute("variant", "outlined"),
      ],
      [text("Child")],
    )
  f |> element([text("Child")]) |> should.equal(expected)

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
  f |> element([text("Child")]) |> should.equal(expected)
}

pub fn form_field_setters_test() {
  let f = basic()

  f
  |> float_label(Always)
  |> fn(f) { f.float_label }
  |> should.equal(Always)

  f
  |> hide_required_marker(True)
  |> fn(f) { f.hide_required_marker }
  |> should.be_true()

  f
  |> hide_subscript(NeverHide)
  |> fn(f) { f.hide_subscript }
  |> should.equal(NeverHide)

  f
  |> variant(Filled)
  |> fn(f) { f.variant }
  |> should.equal(Filled)
}
