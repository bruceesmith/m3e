import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute, disabled, name, selected}
import lustre/element
import lustre/element/html.{span, text}
import m3e/button.{
  Elevated, Filled, Large, Outlined, Reset, Square, Submit, Text, basic, element,
  form, icons, key, label, selected_label, set_type, shape, size, toggle, value,
  variant,
}

pub fn button_creation_test() {
  let b = basic("Click me", Text)
  let expected_basic =
    element.element(
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
  element(b, []) |> should.equal(expected_basic)

  let b_full =
    button.button(
      "Full",
      Some(Filled),
      Some(Square),
      Some(Large),
      [],
      Some("Selected"),
      True,
      True,
      True,
      Some(Submit),
      Some("key"),
      Some("val"),
    )

  let expected_full =
    element.element(
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
  element(b_full, []) |> should.equal(expected_full)
}

pub fn button_element_test() {
  let b = basic("Basic", Text)
  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}

pub fn button_form_test() {
  let b = basic("Submit", Filled) |> form(Some(Submit), Some("k"), Some("v"))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("variant", "filled"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
        attribute("type", "submit"),
        name("k"),
        attribute("value", "v"),
      ],
      [text("Submit"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_key_test() {
  let b = basic("Key", Text) |> key(Some("my-key"))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
        name("my-key"),
      ],
      [text("Key"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_selected_label_test() {
  let b = basic("Toggle", Outlined) |> selected_label("On")

  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}

pub fn button_shape_test() {
  let b = basic("Shape", Text) |> shape(Square)

  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}

pub fn button_size_test() {
  let b = basic("Size", Text) |> size(Large)

  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}

pub fn button_set_type_test() {
  let b = basic("Reset", Text) |> set_type(Reset)

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
        attribute("type", "reset"),
      ],
      [text("Reset"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_value_test() {
  let b = basic("Value", Text) |> value(Some("123"))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("variant", "text"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        selected(False),
        disabled(False),
        attribute("value", "123"),
      ],
      [text("Value"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_variant_test() {
  let b = basic("Variant", Text) |> variant(Elevated)

  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}

pub fn button_icons_test() {
  let icon = span([], [text("icon")])
  let b = basic("Icon", Text) |> icons([icon])

  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}

pub fn button_label_test() {
  let b = basic("Original", Text) |> label("New Label")

  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}

pub fn button_toggle_test() {
  let b = basic("Toggle Me", Text) |> toggle(True)

  let expected =
    element.element(
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
  b |> element([]) |> should.equal(expected)
}
