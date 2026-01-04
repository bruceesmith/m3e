import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute, name}
import lustre/element
import lustre/element/html.{text}
import m3e/chip.{
  Assist, Filter, Information, Input, Suggestion, assist, behaviour, disabled,
  element, filter, form, icon, information, input, removable, selected,
  suggestion, variant,
}
import m3e/icon

pub fn chip_creation_test() {
  let c = assist("Assist")
  c.label |> should.equal("Assist")
  c.type_ |> should.equal(Assist)
  c.disabled |> should.be_false()

  let c = filter("Filter")
  c.label |> should.equal("Filter")
  c.type_ |> should.equal(Filter)

  let c = information("Info")
  c.label |> should.equal("Info")
  c.type_ |> should.equal(Information)

  let c = input("Input")
  c.label |> should.equal("Input")
  c.type_ |> should.equal(Input)

  let c = suggestion("Suggestion")
  c.label |> should.equal("Suggestion")
  c.type_ |> should.equal(Suggestion)
}

pub fn chip_element_test() {
  let c = assist("Assist")
  let expected =
    element.element(
      "m3e-assist-chip",
      [attribute("variant", "outlined")],
      [element.none(), text("Assist")],
    )
  c |> element([], []) |> should.equal(expected)

  let c = information("Info")
  let expected =
    element.element(
      "m3e-chip",
      [attribute("variant", "outlined")],
      [element.none(), text("Info")],
    )
  c |> element([], []) |> should.equal(expected)
}

pub fn chip_behaviour_test() {
  // Test with Assist chip (supports behaviour)
  let c = assist("Reset") |> behaviour(chip.Reset)
  c.behaviour |> should.equal(chip.Reset)

  let expected =
    element.element(
      "m3e-assist-chip",
      [attribute("type", "reset"), attribute("variant", "outlined")],
      [element.none(), text("Reset")],
    )
  c |> element([], []) |> should.equal(expected)

  // Test with Information chip (does not support behaviour)
  let c_info = information("Info") |> behaviour(chip.Submit)
  c_info.behaviour |> should.equal(chip.Normal)
}

pub fn chip_disabled_test() {
  // Assist supports disabled
  let c = assist("Disabled") |> disabled(True)
  c.disabled |> should.be_true()

  let expected =
    element.element(
      "m3e-assist-chip",
      [attribute("disabled", ""), attribute("variant", "outlined")],
      [element.none(), text("Disabled")],
    )
  c |> element([], []) |> should.equal(expected)

  // Information does not support disabled
  let c_info = information("Info") |> disabled(True)
  c_info.disabled |> should.be_false()
}

pub fn chip_form_test() {
  // Filter supports form attributes
  let c = filter("Filter") |> form(Some("name"), Some("value"))
  c.key |> should.equal(Some("name"))
  c.value |> should.equal(Some("value"))

  let expected =
    element.element(
      "m3e-filter-chip",
      [
        name("name"),
        attribute("value", "value"),
        attribute("variant", "outlined"),
      ],
      [element.none(), text("Filter")],
    )
  c |> element([], []) |> should.equal(expected)

  // Assist does not support form attributes
  let c_assist = assist("Assist") |> form(Some("n"), Some("v"))
  c_assist.key |> should.equal(None)
}

pub fn chip_icon_test() {
  let i = icon.basic("star")

  // Assist supports icon
  let c = assist("Icon") |> icon(i)
  c.icon |> should.equal(Some(i))

  let expected =
    element.element(
      "m3e-assist-chip",
      [attribute("variant", "outlined")],
      [icon.element(i, [], []), text("Icon")],
    )
  c |> element([], []) |> should.equal(expected)

  // Input does not support icon via this function (based on source)
  let c_input = input("Input") |> icon(i)
  c_input.icon |> should.equal(None)
}

pub fn chip_removable_test() {
  // Input supports removable
  let c = input("Removable") |> removable(True)
  c.removable |> should.be_true()

  let expected =
    element.element(
      "m3e-input-chip",
      [attribute("removable", ""), attribute("variant", "outlined")],
      [element.none(), text("Removable")],
    )
  c |> element([], []) |> should.equal(expected)

  // Filter does not support removable
  let c_filter = filter("Filter") |> removable(True)
  c_filter.removable |> should.be_false()
}

pub fn chip_selected_test() {
  // Filter supports selected
  let c = filter("Selected") |> selected(True)
  c.selected |> should.be_true()

  let expected =
    element.element(
      "m3e-filter-chip",
      [attribute("selected", ""), attribute("variant", "outlined")],
      [element.none(), text("Selected")],
    )
  c |> element([], []) |> should.equal(expected)

  // Assist does not support selected
  let c_assist = assist("Assist") |> selected(True)
  c_assist.selected |> should.be_false()
}

pub fn chip_variant_test() {
  let c = assist("Elevated") |> variant(chip.Elevated)
  c.variant |> should.equal(chip.Elevated)

  let expected =
    element.element(
      "m3e-assist-chip",
      [attribute("variant", "elevated")],
      [element.none(), text("Elevated")],
    )
  c |> element([], []) |> should.equal(expected)
}
