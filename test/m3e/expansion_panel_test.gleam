import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element, text}
import lustre/element/html
import m3e/expansion_panel.{
  Config, HideToggle, Open, Start, ToggleIcon, default_config,
}
import m3e/icon
import m3e/state.{Disabled}

const header_text = "Panel Header"

pub fn defaults_test() {
  let p = expansion_panel.new(header_text)
  let expected =
    element(
      "m3e-expansion-panel",
      [
        attribute("toggle-direction", "end"),
        attribute("toggle-position", "end"),
      ],
      [html.span([attribute("slot", "header")], [text(header_text)])],
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
    element(
      "m3e-expansion-panel",
      [
        attribute("disabled", ""),
        attribute("hide-toggle", ""),
        attribute("open", ""),
        attribute("toggle-direction", "start"),
        attribute("toggle-position", "start"),
      ],
      [html.span([attribute("slot", "header")], [text(header_text)])],
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
    element(
      "m3e-expansion-panel",
      [
        attribute("toggle-direction", "end"),
        attribute("toggle-position", "end"),
      ],
      [
        html.span([attribute("slot", "header")], [text(header_text)]),
        expected_icon,
      ],
    )
  expansion_panel.render(p, [], []) |> should.equal(expected)
}

pub fn actions_test() {
  let action_btn = html.button([], [text("Action")])
  let p =
    expansion_panel.new(header_text)
    |> expansion_panel.actions(Some([action_btn]))

  let expected =
    element(
      "m3e-expansion-panel",
      [
        attribute("toggle-direction", "end"),
        attribute("toggle-position", "end"),
      ],
      [
        html.span([attribute("slot", "header")], [text(header_text)]),
        element("div", [attribute("slot", "actions")], [action_btn]),
      ],
    )
  expansion_panel.render(p, [], []) |> should.equal(expected)
}

pub fn render_config_test() {
  let config =
    Config(
      ..default_config(),
      header: header_text,
      interaction: Disabled,
      state: Open,
    )
  let expected =
    element(
      "m3e-expansion-panel",
      [
        attribute("disabled", ""),
        attribute("open", ""),
        attribute("toggle-direction", "end"),
        attribute("toggle-position", "end"),
      ],
      [html.span([attribute("slot", "header")], [text(header_text)])],
    )

  expansion_panel.render_config(config, [], [])
  |> should.equal(expected)
}
