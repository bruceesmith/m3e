import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element, text}
import lustre/element/html
import m3e/expansion_panel.{ToggleIcon}
import m3e/icon

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
    |> expansion_panel.disabled(True)
    |> expansion_panel.hide_toggle(True)
    |> expansion_panel.open(True)
    |> expansion_panel.toggle_direction(expansion_panel.Start)
    |> expansion_panel.toggle_position(expansion_panel.Start)

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

pub fn children_test() {
  let content = text("Panel Content")
  let p = expansion_panel.new(header_text)

  let expected =
    element(
      "m3e-expansion-panel",
      [
        attribute("toggle-direction", "end"),
        attribute("toggle-position", "end"),
      ],
      [html.span([attribute("slot", "header")], [text(header_text)]), content],
    )
  expansion_panel.render(p, [], [content]) |> should.equal(expected)
}
