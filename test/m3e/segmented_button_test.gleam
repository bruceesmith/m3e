import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/segmented_button.{
  disabled, hide_selection_indicator, multi, name, new, render,
}

pub fn segmented_button_creation_test() {
  let s = new()
  let expected = element("m3e-segmented-button", [], [])
  render(s, [], []) |> should.equal(expected)
}

pub fn segmented_button_render_test() {
  let s = new()
  let expected =
    element("m3e-segmented-button", [attribute("class", "extra")], [
      text("Child"),
    ])
  render(s, [attribute("class", "extra")], [text("Child")])
  |> should.equal(expected)
}

pub fn segmented_button_setters_test() {
  let s =
    new()
    |> disabled(True)
    |> hide_selection_indicator(True)
    |> multi(True)
    |> name(Some("group"))

  let expected =
    element(
      "m3e-segmented-button",
      [
        attribute("disabled", ""),
        attribute("hide-selection-indicator", ""),
        attribute("multi", ""),
        attribute("name", "group"),
      ],
      [],
    )
  render(s, [], []) |> should.equal(expected)
}
