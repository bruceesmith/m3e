import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/app_bar
import m3e/config
import m3e/icon_button.{
  Config, Disabled, DisabledInteractive, Filled, Narrow, Square, Toggle,
  default_config, disabled, form, new, purpose, render, render_config, selected,
  shape, size, toggle, variant, width,
}

import m3e/form_submission.{FormSubmission, Submit}
import m3e/state.{Selected}

pub fn icon_button_creation_test() {
  let b = new()
  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.selected(False),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  render(b, [], []) |> should.equal(expected)

  let b =
    new()
    |> disabled(Disabled)
    |> purpose(None)
    |> selected(Selected)
    |> shape(Square)
    |> size(config.Large)
    |> toggle(Toggle)
    |> form(Some(FormSubmission(Submit, "key", "val")))
    |> variant(Filled)
    |> width(Narrow)

  let expected_full =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(True),
        attribute.selected(True),
        attribute.attribute("shape", "square"),
        attribute.attribute("size", "large"),
        attribute.attribute("toggle", ""),
        attribute.attribute("type", "submit"),
        attribute.attribute("name", "key"),
        attribute.value("val"),
        attribute.attribute("variant", "filled"),
        attribute.attribute("width", "narrow"),
      ],
      [],
    )
  render(b, [], []) |> should.equal(expected_full)
}

pub fn icon_button_render_test() {
  let b = new()
  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.selected(False),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_purpose_test() {
  let b = new() |> purpose(Some(app_bar.slot(app_bar.LeadingIcon)))

  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.attribute("slot", "leading-icon"),
        attribute.selected(False),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_test() {
  let b = new() |> disabled(Disabled)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(True),
        attribute.selected(False),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_interactive_test() {
  let b = new() |> disabled(DisabledInteractive)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.attribute("disabled-interactive", ""),
        attribute.selected(False),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_selected_test() {
  let b = new() |> selected(Selected)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.selected(True),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_shape_test() {
  let b = new() |> shape(Square)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.selected(False),
        attribute.attribute("shape", "square"),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_size_test() {
  let b = new() |> size(config.ExtraLarge)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.selected(False),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "extra-large"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_toggle_test() {
  let b = new() |> toggle(Toggle)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(False),
        attribute.selected(False),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("toggle", ""),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_render_config_test() {
  let config =
    Config(
      ..default_config(),
      interaction: Disabled,
      selection: Selected,
      toggle: Toggle,
      size: config.ExtraSmall,
    )
  let expected =
    element.element(
      "m3e-icon-button",
      [
        attribute.disabled(True),
        attribute.selected(True),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("toggle", ""),
        attribute.attribute("variant", "standard"),
        attribute.attribute("width", "default"),
      ],
      [],
    )

  render_config(config, [], [])
  |> should.equal(expected)
}
