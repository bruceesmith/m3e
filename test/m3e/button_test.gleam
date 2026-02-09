import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute, disabled, selected}
import lustre/element.{element}
import lustre/element/html.{span, text}
import m3e/button.{
  Elevated, Filled, Large, Outlined, Square, Text, form, icons, label, new,
  render, selected_label, shape, size, toggle, variant,
}
import m3e/helpers.{Submit}

pub fn button_creation_test() {
  let b = new("Click me", Text)
  let expected_basic =
    element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
      ],
      [text("Click me"), element.none()],
    )
  render(b, []) |> should.equal(expected_basic)

  let b_full =
    new("Full", Filled)
    |> shape(Square)
    |> size(Large)
    |> selected_label("Selected")
    |> toggle(True)
    |> button.selected(True)
    |> button.disabled(True)
    |> form(Some(Submit), Some("key"), Some("val"))

  let expected_full =
    element(
      "m3e-button",
      [
        attribute("variant", "filled"),
        attribute("shape", "square"),
        attribute("size", "large"),
        attribute("toggle", ""),
        selected(True),
        disabled(True),
        attribute("type", "submit"),
        attribute("name", "key"),
        attribute("value", "val"),
      ],
      [text("Full"), span([attribute("slot", "selected")], [text("Selected")])],
    )
  render(b_full, []) |> should.equal(expected_full)
}

pub fn button_element_test() {
  let b = new("Basic", Text)
  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
      ],
      [text("Basic"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_form_test() {
  let b = new("Submit", Filled) |> form(Some(Submit), Some("k"), Some("v"))

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "filled"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
        attribute("type", "submit"),
        attribute.name("k"),
        attribute("value", "v"),
      ],
      [text("Submit"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_selected_label_test() {
  let b = new("Toggle", Outlined) |> selected_label("On")

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "outlined"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
      ],
      [
        text("Toggle"),
        span([attribute("slot", "selected")], [text("On")]),
      ],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_shape_test() {
  let b = new("Shape", Text) |> shape(Square)

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "square"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
      ],
      [text("Shape"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_size_test() {
  let b = new("Size", Text) |> size(Large)

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "large"),
        selected(False),
        disabled(False),
      ],
      [text("Size"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_variant_test() {
  let b = new("Variant", Text) |> variant(Elevated)

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "elevated"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
      ],
      [text("Variant"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_icons_test() {
  let icon = span([], [text("icon")])
  let b = new("Icon", Text) |> icons([icon])

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
      ],
      [icon, text("Icon"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_label_test() {
  let b = new("Original", Text) |> label("New Label")

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
      ],
      [text("New Label"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}

pub fn button_toggle_test() {
  let b = new("Toggle Me", Text) |> toggle(True)

  let expected =
    element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("toggle", ""),
        selected(False),
        disabled(False),
      ],
      [text("Toggle Me"), element.none()],
    )
  b |> render([]) |> should.equal(expected)
}
