import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute, disabled, selected, value}
import lustre/element
import m3e/icon_button.{
  ExtraLarge, Filled, Large, LeadingIcon, Narrow, Reset, Square, Submit, Tonal,
  Wide, basic, disabled_interactive, icon_button, key, purpose, render, shape,
  size, toggle, type_, variant, width,
}

pub fn icon_button_creation_test() {
  let b = basic()
  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
    icon_button(
      True,
      True,
      "key",
      None,
      True,
      Square,
      Large,
      True,
      Submit,
      "val",
      Filled,
      Narrow,
    )
  let expected_full =
    element.element(
      "m3e-icon-button",
      [
        disabled(True),
        attribute("disabled-interactive", ""),
        attribute("key", "key"),
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
  let b = basic()
  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> purpose(Some(LeadingIcon))

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> icon_button.disabled(True)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(True),
        attribute("key", ""),
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
  let b = basic() |> disabled_interactive(True)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("disabled-interactive", ""),
        attribute("key", ""),
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

pub fn icon_button_key_test() {
  let b = basic() |> key("my-key")

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", "my-key"),
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
  let b = basic() |> icon_button.selected(True)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> shape(Square)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> size(ExtraLarge)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> toggle(True)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> type_(Reset)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> icon_button.value("123")

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> variant(Tonal)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
  let b = basic() |> width(Wide)

  let expected =
    element.element(
      "m3e-icon-button",
      [
        disabled(False),
        attribute("key", ""),
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
