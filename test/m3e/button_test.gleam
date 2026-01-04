import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute, name}
import lustre/element
import lustre/element/html.{span, text}
import m3e/button.{
  Elevated, Filled, Large, Outlined, Reset, Square, Submit, Text, basic, element,
  form, key, selected_label, set_type, shape, size, value, variant,
}

pub fn button_creation_test() {
  let b = basic("Click me", Text)
  b.label |> should.equal("Click me")
  b.variant |> should.equal(Some(Text))
  b.disabled |> should.be_false()
  b.selected |> should.be_false()
  b.toggle |> should.be_false()
  b.icons |> should.equal([])

  let b =
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
  b.label |> should.equal("Full")
  b.variant |> should.equal(Some(Filled))
  b.shape |> should.equal(Some(Square))
  b.size |> should.equal(Some(Large))
  b.selected_label |> should.equal(Some("Selected"))
  b.toggle |> should.be_true()
  b.selected |> should.be_true()
  b.disabled |> should.be_true()
  b.type_ |> should.equal(Some(Submit))
  b.key |> should.equal(Some("key"))
  b.value |> should.equal(Some("val"))
}

pub fn button_element_test() {
  let b = basic("Basic", Text)
  let expected =
    element.element(
      "m3e-button",
      [
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "text"),
      ],
      [text("Basic"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_form_test() {
  let b = basic("Submit", Filled) |> form(Some(Submit), Some("k"), Some("v"))
  b.type_ |> should.equal(Some(Submit))
  b.key |> should.equal(Some("k"))
  b.value |> should.equal(Some("v"))

  let expected =
    element.element(
      "m3e-button",
      [
        name("k"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "submit"),
        attribute("value", "v"),
        attribute("variant", "filled"),
      ],
      [text("Submit"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_key_test() {
  let b = basic("Key", Text) |> key(Some("my-key"))
  b.key |> should.equal(Some("my-key"))

  let expected =
    element.element(
      "m3e-button",
      [
        name("my-key"),
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "text"),
      ],
      [text("Key"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_selected_label_test() {
  let b = basic("Toggle", Outlined) |> selected_label("On")
  b.selected_label |> should.equal(Some("On"))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "outlined"),
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
  b.shape |> should.equal(Some(Square))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("shape", "square"),
        attribute("size", "small"),
        attribute("variant", "text"),
      ],
      [text("Shape"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_size_test() {
  let b = basic("Size", Text) |> size(Large)
  b.size |> should.equal(Some(Large))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("shape", "rounded"),
        attribute("size", "large"),
        attribute("variant", "text"),
      ],
      [text("Size"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_set_type_test() {
  let b = basic("Reset", Text) |> set_type(Reset)
  b.type_ |> should.equal(Some(Reset))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("type", "reset"),
        attribute("variant", "text"),
      ],
      [text("Reset"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_value_test() {
  let b = basic("Value", Text) |> value(Some("123"))
  b.value |> should.equal(Some("123"))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("value", "123"),
        attribute("variant", "text"),
      ],
      [text("Value"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}

pub fn button_variant_test() {
  let b = basic("Variant", Text) |> variant(Elevated)
  b.variant |> should.equal(Some(Elevated))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute("shape", "rounded"),
        attribute("size", "small"),
        attribute("variant", "elevated"),
      ],
      [text("Variant"), element.none()],
    )
  b |> element([]) |> should.equal(expected)
}
