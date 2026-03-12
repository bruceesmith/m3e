import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{
  attribute, disabled as attr_disabled, selected as attr_selected,
  value as attr_value,
}
import lustre/element.{element}

import m3e/app_bar
import m3e/icon_button.{
  ExtraLarge, Filled, Large, Narrow, Square, Tonal, Wide, disabled,
  disabled_interactive, form, new, purpose, render, selected, shape, size,
  toggle, variant, width,
}

// disabled and selected here are the setters, not attributes

import m3e/form_submission.{FormSubmission, Reset, Submit}

pub fn icon_button_creation_test() {
  let b = new()
  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  render(b, [], []) |> should.equal(expected)

  let b =
    new()
    |> disabled(True)
    |> disabled_interactive(True)
    |> purpose(None)
    |> selected(True)
    |> shape(Square)
    |> size(Large)
    |> toggle(True)
    |> form(Some(FormSubmission(Submit, "key", "val")))
    |> variant(Filled)
    |> width(Narrow)

  let expected_full =
    element(
      "m3e-icon-button",
      [
        attr_disabled(True),
        attribute("disabled-interactive", ""),
        attr_selected(True),
        attribute("shape", "square"),
        attribute("size", "large"),
        attribute("toggle", ""),
        attribute("type", "submit"),
        attribute("name", "key"),
        attr_value("val"),
        attribute("variant", "filled"),
        attribute("width", "narrow"),
      ],
      [],
    )
  render(b, [], []) |> should.equal(expected_full)
}

pub fn icon_button_render_test() {
  let b = new()
  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_purpose_test() {
  let b = new() |> purpose(Some(app_bar.slot(app_bar.LeadingIcon)))

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attribute("slot", "leading-icon"),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_test() {
  let b = new() |> disabled(True)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(True),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_interactive_test() {
  let b = new() |> disabled_interactive(True)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attribute("disabled-interactive", ""),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_selected_test() {
  let b = new() |> selected(True)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(True),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_shape_test() {
  let b = new() |> shape(Square)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "square"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_size_test() {
  let b = new() |> size(ExtraLarge)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "extra-large"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_toggle_test() {
  let b = new() |> toggle(True)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("toggle", ""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_variant_test() {
  let b = new() |> variant(Tonal)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "tonal"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_width_test() {
  let b = new() |> width(Wide)

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "standard"),
        attribute("width", "wide"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_form_test() {
  let b = new() |> form(Some(FormSubmission(Submit, "test-name", "test-value")))

  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "submit"),
        attribute("name", "test-name"),
        attr_value("test-value"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)

  let b_reset = new() |> form(Some(FormSubmission(Reset, "ignore", "ignore")))

  let expected_reset =
    element(
      "m3e-icon-button",
      [
        attr_disabled(False),
        attr_selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "reset"),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b_reset |> render([], []) |> should.equal(expected_reset)
}
