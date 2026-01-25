import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute, disabled, selected, value}
import lustre/element
import m3e/icon_button.{
  Button, Default, ExtraLarge, Filled, Large, LeadingIcon, Narrow, Reset,
  Rounded, Small, Square, Standard, Submit, Tonal, Wide, basic,
  disabled_interactive, element, icon_button, key, purpose, shape, size, toggle,
  type_, variant, width,
}

pub fn icon_button_creation_test() {
  let b = basic()
  b.disabled |> should.be_false()
  b.disabled_interactive |> should.be_false()
  b.key |> should.equal("")
  b.purpose |> should.equal(None)
  b.selected |> should.be_false()
  b.shape |> should.equal(Rounded)
  b.size |> should.equal(Small)
  b.toggle |> should.be_false()
  b.type_ |> should.equal(Button)
  b.value |> should.equal("")
  b.variant |> should.equal(Standard)
  b.width |> should.equal(Default)

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
  b.disabled |> should.be_true()
  b.disabled_interactive |> should.be_true()
  b.key |> should.equal("key")
  b.purpose |> should.equal(None)
  b.selected |> should.be_true()
  b.shape |> should.equal(Square)
  b.size |> should.equal(Large)
  b.toggle |> should.be_true()
  b.type_ |> should.equal(Submit)
  b.value |> should.equal("val")
  b.variant |> should.equal(Filled)
  b.width |> should.equal(Narrow)
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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_purpose_test() {
  let b = basic() |> purpose(Some(LeadingIcon))
  b.purpose |> should.equal(Some(LeadingIcon))

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_test() {
  let b = basic() |> icon_button.disabled(True)
  b.disabled |> should.be_true()

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_disabled_interactive_test() {
  let b = basic() |> disabled_interactive(True)
  b.disabled_interactive |> should.be_true()

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_key_test() {
  let b = basic() |> key("my-key")
  b.key |> should.equal("my-key")

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_selected_test() {
  let b = basic() |> icon_button.selected(True)
  b.selected |> should.be_true()

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_shape_test() {
  let b = basic() |> shape(Square)
  b.shape |> should.equal(Square)

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_size_test() {
  let b = basic() |> size(ExtraLarge)
  b.size |> should.equal(ExtraLarge)

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_toggle_test() {
  let b = basic() |> toggle(True)
  b.toggle |> should.be_true()

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_type_test() {
  let b = basic() |> type_(Reset)
  b.type_ |> should.equal(Reset)

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_value_test() {
  let b = basic() |> icon_button.value("123")
  b.value |> should.equal("123")

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_variant_test() {
  let b = basic() |> variant(Tonal)
  b.variant |> should.equal(Tonal)

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
  b |> element([], []) |> should.equal(expected)
}

pub fn icon_button_width_test() {
  let b = basic() |> width(Wide)
  b.width |> should.equal(Wide)

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
  b |> element([], []) |> should.equal(expected)
}
