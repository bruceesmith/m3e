import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/app_bar
import m3e/config
import m3e/icon_button.{
  Config, Disabled, DisabledInteractive, Filled, Narrow, Square, Toggle,
}

import m3e/form_submission.{FormSubmission, Submit}
import m3e/state.{Selected}

pub fn icon_button_creation_test() {
  let b = icon_button.new()
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
  icon_button.render(b, [], []) |> should.equal(expected)

  let b =
    icon_button.new()
    |> icon_button.disabled(Disabled)
    |> icon_button.purpose(None)
    |> icon_button.selected(Selected)
    |> icon_button.shape(Square)
    |> icon_button.size(config.Large)
    |> icon_button.toggle(Toggle)
    |> icon_button.form(Some(FormSubmission(Submit, "key", "val")))
    |> icon_button.variant(Filled)
    |> icon_button.width(Narrow)

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
  icon_button.render(b, [], []) |> should.equal(expected_full)
}

pub fn icon_button_render_test() {
  let b = icon_button.new()
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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_purpose_test() {
  let b =
    icon_button.new()
    |> icon_button.purpose(Some(app_bar.slot(app_bar.LeadingIcon)))

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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_test() {
  let b = icon_button.new() |> icon_button.disabled(Disabled)

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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_interactive_test() {
  let b = icon_button.new() |> icon_button.disabled(DisabledInteractive)

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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_selected_test() {
  let b = icon_button.new() |> icon_button.selected(Selected)

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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_shape_test() {
  let b = icon_button.new() |> icon_button.shape(Square)

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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_size_test() {
  let b = icon_button.new() |> icon_button.size(config.ExtraLarge)

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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_toggle_test() {
  let b = icon_button.new() |> icon_button.toggle(Toggle)

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
  b |> icon_button.render([], []) |> should.equal(expected)
}

pub fn icon_button_render_config_test() {
  let config =
    Config(
      ..icon_button.default_config(),
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

  icon_button.render_config(config, [], [])
  |> should.equal(expected)
}
