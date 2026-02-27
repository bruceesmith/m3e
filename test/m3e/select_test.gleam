import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/select.{
  disabled, hide_selection_indicator, id, multi, name, new, render, required,
}

pub fn select_creation_test() {
  let s = new()
  let expected = element("m3e-select", [], [])
  render(s, [], []) |> should.equal(expected)
}

pub fn select_render_test() {
  let s = new()
  let expected =
    element("m3e-select", [attribute("class", "extra")], [text("Option")])
  render(s, [attribute("class", "extra")], [text("Option")])
  |> should.equal(expected)
}

pub fn select_setters_test() {
  let s =
    new()
    |> disabled(True)
    |> hide_selection_indicator(True)
    |> id(Some("my-id"))
    |> multi(True)
    |> name(Some("my-name"))
    |> required(True)

  let expected =
    element(
      "m3e-select",
      [
        attribute("disabled", ""),
        attribute("hide-selection-indicator", ""),
        attribute("id", "my-id"),
        attribute("multi", ""),
        attribute("name", "my-name"),
        attribute("required", ""),
      ],
      [],
    )
  render(s, [], []) |> should.equal(expected)
}
