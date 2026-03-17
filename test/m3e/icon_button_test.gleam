import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{
  attribute, disabled as attr_disabled, selected as attr_selected,
  value as attr_value,
}
import lustre/element.{element}

import m3e/app_bar
import m3e/icon_button.{
  Config, Disabled, DisabledInteractive, ExtraLarge, ExtraSmall, Filled, Large,
  Narrow, Selected, Square, Toggle, default_config, disabled, form,
  new, purpose, render, render_config, selected, shape, size, toggle, variant,
  width,
}

import m3e/form_submission.{FormSubmission, Submit}

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
    |> disabled(Disabled)
    |> purpose(None)
    |> selected(Selected)
    |> shape(Square)
    |> size(Large)
    |> toggle(Toggle)
    |> form(Some(FormSubmission(Submit, "key", "val")))
    |> variant(Filled)
    |> width(Narrow)

  let expected_full =
    element(
      "m3e-icon-button",
      [
        attr_disabled(True),
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
  let b = new() |> disabled(Disabled)

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
  let b = new() |> disabled(DisabledInteractive)

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
  let b = new() |> selected(Selected)

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
  let b = new() |> toggle(Toggle)

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

pub fn icon_button_render_config_test() {
  let config =
    Config(
      ..default_config(),
      interaction: Disabled,
      selection: Selected,
      toggle: Toggle,
      size: ExtraSmall,
    )
  let expected =
    element(
      "m3e-icon-button",
      [
        attr_disabled(True),
        attr_selected(True),
        attribute("shape", "rounded"),
        attribute("size", "extra-small"),
        attribute("toggle", ""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )

  render_config(config, [], [])
  |> should.equal(expected)
}
