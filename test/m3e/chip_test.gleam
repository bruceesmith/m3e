import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute, name}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/chip.{
  assist, behaviour, disabled, filter, form, icon, information, input, removable,
  render, selected, variant,
}
import m3e/icon

pub fn chip_creation_test() {
  let c = assist("Assist")
  let expected =
    element("m3e-assist-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Assist"),
    ])
  render(c, [], []) |> should.equal(expected)

  let c = filter("Filter")
  let expected =
    element("m3e-filter-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Filter"),
    ])
  render(c, [], []) |> should.equal(expected)

  let c = information("Info")
  let expected =
    element("m3e-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Info"),
    ])
  render(c, [], []) |> should.equal(expected)

  let c = input("Input")
  let expected =
    element("m3e-input-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Input"),
    ])
  render(c, [], []) |> should.equal(expected)
}

pub fn chip_element_test() {
  let c = assist("Assist")
  let expected =
    element("m3e-assist-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Assist"),
    ])
  c |> render([], []) |> should.equal(expected)

  let c = information("Info")
  let expected =
    element("m3e-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Info"),
    ])
  c |> render([], []) |> should.equal(expected)
}

pub fn chip_behaviour_test() {
  // Test with Assist chip (supports behaviour)
  let c = assist("Reset") |> behaviour(chip.Reset)

  let expected =
    element(
      "m3e-assist-chip",
      [attribute("type", "reset"), attribute("variant", "outlined")],
      [element.none(), text("Reset")],
    )
  c |> render([], []) |> should.equal(expected)

  // Test with Information chip (does not support behaviour)
  let c_info = information("Info") |> behaviour(chip.Submit)
  let expected_info =
    element("m3e-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Info"),
    ])
  render(c_info, [], []) |> should.equal(expected_info)
}

pub fn chip_disabled_test() {
  // Assist supports disabled
  let c = assist("Disabled") |> disabled(True)

  let expected =
    element(
      "m3e-assist-chip",
      [attribute("disabled", ""), attribute("variant", "outlined")],
      [element.none(), text("Disabled")],
    )
  c |> render([], []) |> should.equal(expected)

  // Information does not support disabled
  let c_info = information("Info") |> disabled(True)
  let expected_info =
    element("m3e-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Info"),
    ])
  render(c_info, [], []) |> should.equal(expected_info)
}

pub fn chip_form_test() {
  // Filter supports form attributes
  let c = filter("Filter") |> form(Some("name"), Some("value"))

  let expected =
    element(
      "m3e-filter-chip",
      [
        name("name"),
        attribute("value", "value"),
        attribute("variant", "outlined"),
      ],
      [element.none(), text("Filter")],
    )
  c |> render([], []) |> should.equal(expected)

  // Assist does not support form attributes
  let c_assist = assist("Assist") |> form(Some("n"), Some("v"))
  let expected_assist =
    element("m3e-assist-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Assist"),
    ])
  render(c_assist, [], []) |> should.equal(expected_assist)
}

pub fn chip_icon_test() {
  let i = icon.new("star")

  // Assist supports icon
  let c = assist("Icon") |> icon(i)

  let expected =
    element("m3e-assist-chip", [attribute("variant", "outlined")], [
      icon.render(i, [], []),
      text("Icon"),
    ])
  c |> render([], []) |> should.equal(expected)

  // Input does not support icon via this function (based on source)
  let c_input = input("Input") |> icon(i)
  let expected_input =
    element("m3e-input-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Input"),
    ])
  render(c_input, [], []) |> should.equal(expected_input)
}

pub fn chip_removable_test() {
  // Input supports removable
  let c = input("Removable") |> removable(True)

  let expected =
    element(
      "m3e-input-chip",
      [attribute("removable", ""), attribute("variant", "outlined")],
      [element.none(), text("Removable")],
    )
  c |> render([], []) |> should.equal(expected)

  // Filter does not support removable
  let c_filter = filter("Filter") |> removable(True)
  let expected_filter =
    element("m3e-filter-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Filter"),
    ])
  render(c_filter, [], []) |> should.equal(expected_filter)
}

pub fn chip_selected_test() {
  // Filter supports selected
  let c = filter("Selected") |> selected(True)

  let expected =
    element(
      "m3e-filter-chip",
      [attribute("selected", ""), attribute("variant", "outlined")],
      [element.none(), text("Selected")],
    )
  c |> render([], []) |> should.equal(expected)

  // Assist does not support selected
  let c_assist = assist("Assist") |> selected(True)
  let expected_assist =
    element("m3e-assist-chip", [attribute("variant", "outlined")], [
      element.none(),
      text("Assist"),
    ])
  render(c_assist, [], []) |> should.equal(expected_assist)
}

pub fn chip_variant_test() {
  let c = assist("Elevated") |> variant(chip.Elevated)

  let expected =
    element("m3e-assist-chip", [attribute("variant", "elevated")], [
      element.none(),
      text("Elevated"),
    ])
  c |> render([], []) |> should.equal(expected)
}
