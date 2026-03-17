import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/form_field.{
  Always, AlwaysHide, Config, Filled, HideRequiredMarker, NeverHide,
  default_config, float_label, hide_required_marker, hide_subscript, new, render,
  render_config, variant,
}

pub fn form_field_creation_test() {
  let f = new()
  let expected_attributes = [
    attribute("float-label", "auto"),
    attribute("hide-subscript", "auto"),
    attribute("variant", "outlined"),
  ]

  let expected_without_children =
    element("m3e-form-field", expected_attributes, [])
  render(f, [], []) |> should.equal(expected_without_children)

  let expected_with_children =
    element("m3e-form-field", expected_attributes, [text("Child")])
  render(f, [], [text("Child")]) |> should.equal(expected_with_children)
}

pub fn form_field_default_test() {
  let f_without_children =
    new()
    |> float_label(Always)
    |> hide_required_marker(HideRequiredMarker)
    |> hide_subscript(NeverHide)
    |> variant(Filled)

  let expected_without_children =
    element(
      "m3e-form-field",
      [
        attribute("float-label", "always"),
        attribute("hide-required-marker", ""),
        attribute("hide-subscript", "never"),
        attribute("variant", "filled"),
      ],
      [],
    )
  render(f_without_children, [], []) |> should.equal(expected_without_children)

  let f_with_children =
    new()
    |> float_label(Always)
    |> hide_required_marker(HideRequiredMarker)
    |> hide_subscript(AlwaysHide)
    |> variant(Filled)

  let expected_with_children =
    element(
      "m3e-form-field",
      [
        attribute("float-label", "always"),
        attribute("hide-required-marker", ""),
        attribute("hide-subscript", "always"),
        attribute("variant", "filled"),
      ],
      [text("Child")],
    )
  render(f_with_children, [], [text("Child")])
  |> should.equal(expected_with_children)
}

pub fn form_field_setters_test() {
  let f = new()

  let f_float = f |> float_label(Always)
  let expected_float =
    element(
      "m3e-form-field",
      [
        attribute("float-label", "always"),
        attribute("hide-subscript", "auto"),
        attribute("variant", "outlined"),
      ],
      [],
    )
  render(f_float, [], []) |> should.equal(expected_float)

  let f_marker = f |> hide_required_marker(HideRequiredMarker)
  let expected_marker =
    element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-required-marker", ""),
        attribute("hide-subscript", "auto"),
        attribute("variant", "outlined"),
      ],
      [],
    )
  render(f_marker, [], []) |> should.equal(expected_marker)

  let f_sub = f |> hide_subscript(NeverHide)
  let expected_sub =
    element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-subscript", "never"),
        attribute("variant", "outlined"),
      ],
      [],
    )
  render(f_sub, [], []) |> should.equal(expected_sub)

  let f_var = f |> variant(Filled)
  let expected_var =
    element(
      "m3e-form-field",
      [
        attribute("float-label", "auto"),
        attribute("hide-subscript", "auto"),
        attribute("variant", "filled"),
      ],
      [],
    )
  render(f_var, [], []) |> should.equal(expected_var)
}

pub fn form_field_render_config_test() {
  let config =
    Config(
      ..default_config(),
      float_label: Always,
      required_marker: HideRequiredMarker,
      variant: Filled,
    )
  let expected =
    element(
      "m3e-form-field",
      [
        attribute("float-label", "always"),
        attribute("hide-required-marker", ""),
        attribute("hide-subscript", "auto"),
        attribute("variant", "filled"),
      ],
      [text("Config Content")],
    )

  render_config(config, [], [text("Config Content")])
  |> should.equal(expected)
}
