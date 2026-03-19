import gleam/option.{None, Some}
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
    |> disabled(segmented_button.Disabled)
    |> hide_selection_indicator(segmented_button.Hidden)
    |> multi(segmented_button.Multiple)
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

pub fn config_test() {
  let c =
    segmented_button.Config(
      interaction: segmented_button.Disabled,
      indicator_visibility: segmented_button.Hidden,
      selection_mode: segmented_button.Multiple,
      name: Some("config-group"),
    )

  let s = segmented_button.from_config(c)

  render(s, [], [])
  |> should.equal(
    element(
      "m3e-segmented-button",
      [
        attribute("disabled", ""),
        attribute("hide-selection-indicator", ""),
        attribute("multi", ""),
        attribute("name", "config-group"),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = segmented_button.default_config()

  c.interaction |> should.equal(segmented_button.Enabled)
  c.indicator_visibility |> should.equal(segmented_button.Visible)
  c.selection_mode |> should.equal(segmented_button.Single)
  c.name |> should.equal(None)
}

pub fn from_config_test() {
  let c = segmented_button.default_config()
  let s = segmented_button.from_config(c)

  render(s, [], [])
  |> should.equal(render(new(), [], []))
}

pub fn render_config_test() {
  let c = segmented_button.default_config()
  let expected = render(segmented_button.from_config(c), [], [])

  segmented_button.render_config(c, [], [])
  |> should.equal(expected)
}
