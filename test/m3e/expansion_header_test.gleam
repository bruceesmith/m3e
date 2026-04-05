import lustre/attribute
import lustre/element
import m3e/expansion_header.{
  After, Before, Config, HideToggle, Horizontal, ShowToggle, Vertical,
}
import m3e/helpers

pub fn default_config_test() {
  let assert Config(
    hide_toggle: ShowToggle,
    toggle_direction: Vertical,
    toggle_position: After,
  ) = expansion_header.default_config()
}

pub fn render_default_test() {
  let actual =
    expansion_header.new()
    |> expansion_header.render([], [])

  let expected =
    element.element(
      "m3e-expansion-header",
      [
        helpers.boolean_attribute("hide-toggle", False),
        attribute.attribute("toggle-direction", "vertical"),
        attribute.attribute("toggle-position", "after"),
      ],
      [],
    )

  let assert True = actual == expected
}

pub fn setters_test() {
  let actual =
    expansion_header.new()
    |> expansion_header.hide_toggle(HideToggle)
    |> expansion_header.toggle_direction(Horizontal)
    |> expansion_header.toggle_position(Before)
    |> expansion_header.render([attribute.id("test")], [element.text("Header")])

  let expected =
    element.element(
      "m3e-expansion-header",
      [
        helpers.boolean_attribute("hide-toggle", True),
        attribute.attribute("toggle-direction", "horizontal"),
        attribute.attribute("toggle-position", "before"),
        attribute.id("test"),
      ],
      [element.text("Header")],
    )

  let assert True = actual == expected
}

pub fn render_config_test() {
  let config =
    Config(
      hide_toggle: HideToggle,
      toggle_direction: Horizontal,
      toggle_position: Before,
    )

  let actual = expansion_header.render_config(config, [], [])

  let expected =
    expansion_header.new()
    |> expansion_header.hide_toggle(HideToggle)
    |> expansion_header.toggle_direction(Horizontal)
    |> expansion_header.toggle_position(Before)
    |> expansion_header.render([], [])

  let assert True = actual == expected
}

pub fn slot_test() {
  let icon_slot = expansion_header.slot(expansion_header.ToggleIcon)
  let expected = attribute.attribute("slot", "toggle-icon")

  let assert True = icon_slot == expected
}
