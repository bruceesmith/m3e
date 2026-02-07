import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute, disabled, selected, value}
import lustre/element.{element}
import m3e/icon_button.{
  ExtraLarge, Filled, Large, LeadingIcon, Narrow, Reset, Square, Submit, Tonal,
  Wide, disabled_interactive, name, new, purpose, render, shape, size, toggle,
  type_, variant, width,
}

pub fn icon_button_creation_test() {
  let b = new()
  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  render(b, [], []) |> should.equal(expected)

  let b =
    new()
    |> icon_button.disabled(True)
    |> disabled_interactive(True)
    |> name(Some("key"))
    |> purpose(None)
    |> icon_button.selected(True)
    |> shape(Square)
    |> size(Large)
    |> toggle(True)
    |> type_(Submit)
    |> icon_button.value("val")
    |> variant(Filled)
    |> width(Narrow)

  let expected_full =
    element(
      "m3e-icon-button",
      [
        disabled(True),
        attribute("disabled-interactive", ""),
        attribute("name", "key"),
        selected(True),
        attribute("shape", "square"),
        attribute("size", "large"),
        attribute("toggle", ""),
        attribute("type", "submit"),
        value("val"),
        attribute("variant", "filled"),
        attribute("width", "narrow"),
      ],
      [],
    )
  render(b, [], []) |> should.equal(expected_full)
}

pub fn icon_button_element_test() {
  let b = new()
  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_purpose_test() {
  let b = new() |> purpose(Some(LeadingIcon))

  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("slot", "leading-icon"),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_test() {
  let b = new() |> icon_button.disabled(True)

  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(True),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
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
        disabled(False),
        attribute("disabled-interactive", ""),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_name_test() {
  let b = new() |> name(Some("my-key"))

  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("name", "my-key"),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_selected_test() {
  let b = new() |> icon_button.selected(True)

  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(False),
        selected(True),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
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
        disabled(False),
        selected(False),
        attribute("shape", "square"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
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
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "extra-large"),
        attribute("type", "button"),
        value(""),
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
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("toggle", ""),
        attribute("type", "button"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_type_test() {
  let b = new() |> type_(Reset)

  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "reset"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "default"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}

pub fn icon_button_value_test() {
  let b = new() |> icon_button.value("123")

  let expected =
    element(
      "m3e-icon-button",
      [
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value("123"),
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
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
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
        disabled(False),
        selected(False),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "button"),
        value(""),
        attribute("variant", "standard"),
        attribute("width", "wide"),
      ],
      [],
    )
  b |> render([], []) |> should.equal(expected)
}
