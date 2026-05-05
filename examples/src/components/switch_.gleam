import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

import m3e/switch
import m3e/switch_icons

import layout
import model
import msg.{type Msg}
import package.{type Package, Package}
import view_helpers

/// switch displays all facets of the M3E Switch wrapper component
///
fn switch_(model: model.Model) -> Element(Msg) {
  view_helpers.page([
    view_helpers.panel(model, "Basic usage", basic),
    view_helpers.panel(model, "Labels", labels),
    view_helpers.panel(model, "Icons", icons),
    view_helpers.panel(model, "Disabling", disabled),
  ])
}

fn basic(_: model.Model) -> Element(Msg) {
  html.div([], [
    switch.new()
    |> switch.checked(switch.IsChecked)
    |> switch.render([], []),
  ])
}

fn labels(_: model.Model) -> Element(Msg) {
  html.div([layout.switch_style()], [
    html.label([layout.switch_style()], [
      switch.render_config(switch.default_config(), [], []),
      element.text("Switch 1"),
    ]),
    switch.render_config(switch.default_config(), [attribute.id("switch2")], []),
    html.label(
      [
        attribute.for("switch2"),
      ],
      [element.text("Switch 2")],
    ),
  ])
}

fn icons(_: model.Model) -> Element(Msg) {
  html.div([layout.switch_style()], [
    switch.new()
      |> switch.icons(switch_icons.None)
      |> switch.render([], []),
    html.label([], [element.text("None")]),

    switch.new()
      |> switch.checked(switch.IsChecked)
      |> switch.icons(switch_icons.Selected)
      |> switch.render([], []),
    html.label([], [element.text("Selected")]),

    switch.new()
      |> switch.icons(switch_icons.Both)
      |> switch.render([], []),
    html.label([], [element.text("Both")]),
  ])
}

fn disabled(_: model.Model) -> Element(Msg) {
  html.div([layout.switch_style()], [
    html.label([layout.switch_style()], [
      switch.new()
        |> switch.disabled(switch.IsDisabled)
        |> switch.render([], []),
      element.text("Disabled Switch 1"),
    ]),
    switch.new()
      |> switch.checked(switch.IsChecked)
      |> switch.disabled(switch.IsDisabled)
      |> switch.render([attribute.id("disabled-on")], []),
    html.label([attribute.for("disabled-on")], [
      element.text("Disabled Switch 2"),
    ]),
  ])
}

/// package() describes the switch showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.Switch,
    label: "Switch",
    view: switch_,
    msg: msg.SwitchPageSelected,
  )
}
