import gleam/list
import gleam/option.{Some}

import lustre/element.{type Element}
import lustre/element/html

import m3e/state.{Checked, Disabled}
import m3e/switch

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
  html.div(
    [],
    switch.new("basic") |> switch.checked(Checked) |> switch.render([]),
  )
}

fn labels(_: model.Model) -> Element(Msg) {
  html.div(
    [layout.switch_style()],
    list.flatten([
      switch.render_config(
        switch.Config(..switch.default_config(), label: Some("Switch 1")),
        [],
      ),
      switch.render_config(
        switch.Config(
          ..switch.default_config(),
          checked: Checked,
          label: Some("Switch 2"),
        ),
        [],
      ),
    ]),
  )
}

fn icons(_: model.Model) -> Element(Msg) {
  html.div(
    [layout.switch_style()],
    list.flatten([
      switch.new("icons-none")
        |> switch.label(Some("None"))
        |> switch.icon(switch.Neither)
        |> switch.render([]),

      switch.new("icons-selected")
        |> switch.checked(Checked)
        |> switch.label(Some("Selected"))
        |> switch.icon(switch.Selected)
        |> switch.render([]),

      switch.new("icons-both")
        |> switch.label(Some("Both"))
        |> switch.icon(switch.Both)
        |> switch.render([]),
    ]),
  )
}

fn disabled(_: model.Model) -> Element(Msg) {
  html.div(
    [layout.switch_style()],
    list.flatten([
      switch.new("disabled-off")
        |> switch.label(Some("Disabled Off"))
        |> switch.disabled(Disabled)
        |> switch.render([]),
      switch.new("disabled-on")
        |> switch.label(Some("Disabled On"))
        |> switch.checked(Checked)
        |> switch.disabled(Disabled)
        |> switch.render([]),
    ]),
  )
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
