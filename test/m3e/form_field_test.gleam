import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/form_field.{
  Always, AlwaysHide, Config, Filled, HideRequiredMarker, NeverHide,
}

pub fn form_field_creation_test() {
  let f = form_field.new()
  let expected_attributes = [
    attribute.attribute("float-label", "auto"),
    attribute.attribute("hide-subscript", "auto"),
    attribute.attribute("variant", "outlined"),
  ]

  let expected_without_children =
    element.element("m3e-form-field", expected_attributes, [])
  form_field.render(f, [], []) |> should.equal(expected_without_children)

  let expected_with_children =
    element.element("m3e-form-field", expected_attributes, [
      element.text("Child"),
    ])
  form_field.render(f, [], [element.text("Child")])
  |> should.equal(expected_with_children)
}

pub fn form_field_default_test() {
  let f_without_children =
    form_field.new()
    |> form_field.float_label(Always)
    |> form_field.hide_required_marker(HideRequiredMarker)
    |> form_field.hide_subscript(NeverHide)
    |> form_field.variant(Filled)

  let expected_without_children =
    element.element(
      "m3e-form-field",
      [
        attribute.attribute("float-label", "always"),
        attribute.attribute("hide-required-marker", ""),
        attribute.attribute("hide-subscript", "never"),
        attribute.attribute("variant", "filled"),
      ],
      [],
    )
  form_field.render(f_without_children, [], [])
  |> should.equal(expected_without_children)

  let f_with_children =
    form_field.new()
    |> form_field.float_label(Always)
    |> form_field.hide_required_marker(HideRequiredMarker)
    |> form_field.hide_subscript(AlwaysHide)
    |> form_field.variant(Filled)

  let expected_with_children =
    element.element(
      "m3e-form-field",
      [
        attribute.attribute("float-label", "always"),
        attribute.attribute("hide-required-marker", ""),
        attribute.attribute("hide-subscript", "always"),
        attribute.attribute("variant", "filled"),
      ],
      [element.text("Child")],
    )
  form_field.render(f_with_children, [], [element.text("Child")])
  |> should.equal(expected_with_children)
}

pub fn form_field_setters_test() {
  let f = form_field.new()

  let f_float = f |> form_field.float_label(Always)
  let expected_float =
    element.element(
      "m3e-form-field",
      [
        attribute.attribute("float-label", "always"),
        attribute.attribute("hide-subscript", "auto"),
        attribute.attribute("variant", "outlined"),
      ],
      [],
    )
  form_field.render(f_float, [], []) |> should.equal(expected_float)

  let f_marker = f |> form_field.hide_required_marker(HideRequiredMarker)
  let expected_marker =
    element.element(
      "m3e-form-field",
      [
        attribute.attribute("float-label", "auto"),
        attribute.attribute("hide-required-marker", ""),
        attribute.attribute("hide-subscript", "auto"),
        attribute.attribute("variant", "outlined"),
      ],
      [],
    )
  form_field.render(f_marker, [], []) |> should.equal(expected_marker)

  let f_sub = f |> form_field.hide_subscript(NeverHide)
  let expected_sub =
    element.element(
      "m3e-form-field",
      [
        attribute.attribute("float-label", "auto"),
        attribute.attribute("hide-subscript", "never"),
        attribute.attribute("variant", "outlined"),
      ],
      [],
    )
  form_field.render(f_sub, [], []) |> should.equal(expected_sub)

  let f_var = f |> form_field.variant(Filled)
  let expected_var =
    element.element(
      "m3e-form-field",
      [
        attribute.attribute("float-label", "auto"),
        attribute.attribute("hide-subscript", "auto"),
        attribute.attribute("variant", "filled"),
      ],
      [],
    )
  form_field.render(f_var, [], []) |> should.equal(expected_var)
}

pub fn form_field_render_config_test() {
  let config =
    Config(
      ..form_field.default_config(),
      float_label: Always,
      hide_required_marker: HideRequiredMarker,
      variant: Filled,
    )
  let expected =
    element.element(
      "m3e-form-field",
      [
        attribute.attribute("float-label", "always"),
        attribute.attribute("hide-required-marker", ""),
        attribute.attribute("hide-subscript", "auto"),
        attribute.attribute("variant", "filled"),
      ],
      [element.text("Config Content")],
    )

  form_field.render_config(config, [], [element.text("Config Content")])
  |> should.equal(expected)
}
