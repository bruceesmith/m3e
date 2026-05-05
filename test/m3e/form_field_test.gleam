//// FormField unit tests
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/float_label_type
import m3e/form_field.{Config}
import m3e/form_field_variant
import m3e/hide_subscript_type

pub fn form_field_default_config_test() {
  let cases = [
    Config(
      float_label: float_label_type.Auto,
      hide_required_marker: form_field.IsNotHideRequiredMarker,
      hide_subscript: hide_subscript_type.Auto,
      variant: form_field_variant.Outlined,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    form_field.default_config()
    |> should.equal(expected)
  })
}

pub fn form_field_from_config_test() {
  let cases = [
    #(
      form_field.Config(
        float_label: float_label_type.Always,
        hide_required_marker: form_field.IsHideRequiredMarker,
        hide_subscript: hide_subscript_type.Always,
        variant: form_field_variant.Filled,
      ),
      form_field.new()
        |> form_field.float_label(float_label_type.Always)
        |> form_field.hide_required_marker(form_field.IsHideRequiredMarker)
        |> form_field.hide_subscript(hide_subscript_type.Always)
        |> form_field.variant(form_field_variant.Filled),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    form_field.from_config(config)
    |> should.equal(expected)
  })
}

pub fn form_field_new_test() {
  let cases = [
    form_field.from_config(form_field.Config(
      float_label: float_label_type.Auto,
      hide_required_marker: form_field.IsNotHideRequiredMarker,
      hide_subscript: hide_subscript_type.Auto,
      variant: form_field_variant.Outlined,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    form_field.new()
    |> should.equal(expected)
  })
}

pub fn form_field_float_label_test() {
  let mod = form_field.new()
  let cases = [
    #(
      float_label_type.Always,
      form_field.from_config(
        form_field.Config(
          ..form_field.default_config(),
          float_label: float_label_type.Always,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    form_field.float_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn form_field_hide_required_marker_test() {
  let mod = form_field.new()
  let cases = [
    #(
      form_field.IsHideRequiredMarker,
      form_field.from_config(
        form_field.Config(
          ..form_field.default_config(),
          hide_required_marker: form_field.IsHideRequiredMarker,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    form_field.hide_required_marker(mod, field)
    |> should.equal(expected)
  })
}

pub fn form_field_hide_subscript_test() {
  let mod = form_field.new()
  let cases = [
    #(
      hide_subscript_type.Always,
      form_field.from_config(
        form_field.Config(
          ..form_field.default_config(),
          hide_subscript: hide_subscript_type.Always,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    form_field.hide_subscript(mod, field)
    |> should.equal(expected)
  })
}

pub fn form_field_variant_test() {
  let mod = form_field.new()
  let cases = [
    #(
      form_field_variant.Filled,
      form_field.from_config(
        form_field.Config(
          ..form_field.default_config(),
          variant: form_field_variant.Filled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    form_field.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn form_field_render_test() {
  let mod = form_field.new()

  let mod_float_label =
    form_field.new() |> form_field.float_label(float_label_type.Always)
  let mod_hide_required_marker =
    form_field.new()
    |> form_field.hide_required_marker(form_field.IsHideRequiredMarker)
  let mod_hide_subscript =
    form_field.new() |> form_field.hide_subscript(hide_subscript_type.Always)
  let mod_variant =
    form_field.new() |> form_field.variant(form_field_variant.Filled)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-form-field", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-form-field", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-form-field", [], [html.br([])]),
    ),

    // Happy path with a float_label attribute
    #(
      #(mod_float_label, [], []),
      element.element(
        "m3e-form-field",
        [
          attribute.attribute(
            "float-label",
            float_label_type.to_string(float_label_type.Always),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a hide_required_marker attribute
    #(
      #(mod_hide_required_marker, [], []),
      element.element(
        "m3e-form-field",
        [attribute.attribute("hide-required-marker", "")],
        [],
      ),
    ),
    // Happy path with a hide_subscript attribute
    #(
      #(mod_hide_subscript, [], []),
      element.element(
        "m3e-form-field",
        [
          attribute.attribute(
            "hide-subscript",
            hide_subscript_type.to_string(hide_subscript_type.Always),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-form-field",
        [
          attribute.attribute(
            "variant",
            form_field_variant.to_string(form_field_variant.Filled),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    form_field.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn form_field_slot_test() {
  let cases = [
    #(form_field.Prefix, attribute.attribute("slot", "prefix")),
    #(form_field.PrefixText, attribute.attribute("slot", "prefix-text")),
    #(form_field.Suffix, attribute.attribute("slot", "suffix")),
    #(form_field.SuffixText, attribute.attribute("slot", "suffix-text")),
    #(form_field.Hint, attribute.attribute("slot", "hint")),
    #(form_field.Error, attribute.attribute("slot", "error")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    form_field.slot(s)
    |> should.equal(expected)
  })
}
