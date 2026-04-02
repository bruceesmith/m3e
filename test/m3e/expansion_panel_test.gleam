import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/expansion_panel.{Config, HideToggle, Open, Start, ToggleIcon}
import m3e/icon
import m3e/state.{Disabled}

const header_text = "Panel Header"

pub fn defaults_test() {
  let p = expansion_panel.new(header_text)
  let expected =
    element.element(
      "m3e-expansion-panel",
      [
        attribute.attribute("toggle-direction", "end"),
        attribute.attribute("toggle-position", "end"),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          element.text(header_text),
        ]),
      ],
    )
  expansion_panel.render(p, [], []) |> should.equal(expected)
}

pub fn attributes_test() {
  let p =
    expansion_panel.new(header_text)
    |> expansion_panel.disabled(Disabled)
    |> expansion_panel.hide_toggle(HideToggle)
    |> expansion_panel.open(Open)
    |> expansion_panel.toggle_direction(Start)
    |> expansion_panel.toggle_position(Start)

  let expected =
    element.element(
      "m3e-expansion-panel",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("hide-toggle", ""),
        attribute.attribute("open", ""),
        attribute.attribute("toggle-direction", "start"),
        attribute.attribute("toggle-position", "start"),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          element.text(header_text),
        ]),
      ],
    )
  expansion_panel.render(p, [], []) |> should.equal(expected)
}

pub fn icon_test() {
  let p =
    expansion_panel.new(header_text)
    |> expansion_panel.toggle_icon_name(Some("chevron_right"))

  let expected_icon =
    icon.new("chevron_right")
    |> icon.purpose(expansion_panel.slot(ToggleIcon))
    |> icon.render([], [])

  let expected =
    element.element(
      "m3e-expansion-panel",
      [
        attribute.attribute("toggle-direction", "end"),
        attribute.attribute("toggle-position", "end"),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          element.text(header_text),
        ]),
        expected_icon,
      ],
    )
  expansion_panel.render(p, [], []) |> should.equal(expected)
}

pub fn actions_test() {
  let action_btn = html.button([], [element.text("Action")])
  let p =
    expansion_panel.new(header_text)
    |> expansion_panel.actions(Some([action_btn]))

  let expected =
    element.element(
      "m3e-expansion-panel",
      [
        attribute.attribute("toggle-direction", "end"),
        attribute.attribute("toggle-position", "end"),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          element.text(header_text),
        ]),
        element.element("div", [attribute.attribute("slot", "actions")], [
          action_btn,
        ]),
      ],
    )
  expansion_panel.render(p, [], []) |> should.equal(expected)
}

pub fn render_config_test() {
  let config =
    Config(
      ..expansion_panel.default_config(),
      header: header_text,
      disabled: Disabled,
      open: Open,
    )
  let expected =
    element.element(
      "m3e-expansion-panel",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("open", ""),
        attribute.attribute("toggle-direction", "end"),
        attribute.attribute("toggle-position", "end"),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          element.text(header_text),
        ]),
      ],
    )

  expansion_panel.render_config(config, [], [])
  |> should.equal(expected)
}
