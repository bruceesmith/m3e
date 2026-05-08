import gleam/option.{Some}

import lustre/element.{type Element}
import lustre/element/html

import m3e/button
import m3e/button_shape
import m3e/button_size
import m3e/button_variant
import m3e/icon
import m3e/link_target

import layout
import model
import msg.{type Msg}
import package.{type Package, Package}
import view_helpers

/// button displays all facets of the M3E Button wrapper component
///
fn button(model: model.Model) -> Element(Msg) {
  view_helpers.page([
    view_helpers.panel(model, "Variants", variant),
    view_helpers.panel(model, "Shapes", shape),
    view_helpers.panel(model, "Sizes", sizes),
    view_helpers.panel(model, "Icons", icons),
    view_helpers.panel(model, "Toggling", toggling),
    view_helpers.panel(model, "Disabling", disabling),
    view_helpers.panel(model, "Links", links),
  ])
}

fn sizes(_: model.Model) -> Element(Msg) {
  html.div([layout.button_style()], [
    button.new()
      |> button.size(button_size.ExtraSmall)
      |> button.variant(button_variant.Tonal)
      |> button.render([], [element.text("Extra Small")]),
    button.new()
      |> button.size(button_size.Small)
      |> button.variant(button_variant.Tonal)
      |> button.render([], [element.text("Small")]),
    button.new()
      |> button.size(button_size.Medium)
      |> button.variant(button_variant.Tonal)
      |> button.render([], [element.text("Medium")]),
    button.new()
      |> button.size(button_size.Large)
      |> button.variant(button_variant.Tonal)
      |> button.render([], [element.text("Large")]),
    button.new()
      |> button.size(button_size.ExtraLarge)
      |> button.variant(button_variant.Tonal)
      |> button.render([], [element.text("Extra Large")]),
  ])
}

fn icons(_: model.Model) -> Element(Msg) {
  html.div([layout.button_style()], [
    button.new()
      |> button.variant(button_variant.Tonal)
      |> button.render([], [
        icon.new()
          |> icon.name("send")
          |> icon.render([button.slot(button.Icon)]),
        element.text("Send"),
      ]),

    button.new()
      |> button.variant(button_variant.Tonal)
      |> button.render([], [
        icon.new()
          |> icon.name("open_in_new_window")
          |> icon.render([button.slot(button.TrailingIcon)]),
        element.text("Open"),
      ]),
  ])
}

fn toggling(_: model.Model) -> Element(Msg) {
  html.div([layout.button_style()], [
    button.new()
      |> button.toggle(button.IsToggle)
      |> button.variant(button_variant.Elevated)
      |> button.render([], [element.text("Elevated toggle")]),
    button.new()
      |> button.toggle(button.IsToggle)
      |> button.variant(button_variant.Filled)
      |> button.render([], [element.text("Filled toggle")]),
    button.new()
      |> button.toggle(button.IsToggle)
      |> button.variant(button_variant.Tonal)
      |> button.render([], [element.text("Tonal toggle")]),
    button.new()
      |> button.toggle(button.IsToggle)
      |> button.variant(button_variant.Outlined)
      |> button.render([], [element.text("Outlined toggle")]),
    button.new()
      |> button.toggle(button.IsToggle)
      |> button.variant(button_variant.Tonal)
      |> button.render([], [
        icon.new()
          |> icon.name("play_arrow")
          |> icon.render([button.slot(button.Icon)]),
        icon.new()
          |> icon.name("stop")
          |> icon.render([button.slot(button.SelectedIcon)]),
        element.text("Start"),
        html.span([button.slot(button.Selected)], [element.text("Stop")]),
      ]),
  ])
}

fn disabling(_: model.Model) -> Element(Msg) {
  html.div([layout.button_style()], [
    button.new()
      |> button.disabled(button.IsDisabled)
      |> button.variant(button_variant.Filled)
      |> button.render([], [element.text("Disabled")]),
    button.new()
      |> button.disabled_interactive(button.IsDisabledInteractive)
      |> button.variant(button_variant.Filled)
      |> button.render([], [element.text("Disabled interactive")]),
  ])
}

fn links(_: model.Model) -> Element(Msg) {
  html.div([layout.button_style()], [
    button.new()
    |> button.href("https://google.com")
    |> button.target(Some(link_target.Blank))
    |> button.variant(button_variant.Tonal)
    |> button.render([], [
      element.text("Google"),
      icon.new()
        |> icon.name("open_in_new_window")
        |> icon.render([button.slot(button.TrailingIcon)]),
    ]),
  ])
}

fn shape(_: model.Model) -> Element(Msg) {
  html.div([layout.button_style()], [
    button.new()
      |> button.shape(button_shape.Rounded)
      |> button.variant(button_variant.Filled)
      |> button.render([], [element.text("Rounded Filled")]),
    button.new()
      |> button.shape(button_shape.Square)
      |> button.variant(button_variant.Filled)
      |> button.render([], [element.text("Square Filled")]),
  ])
}

fn variant(_: model.Model) -> Element(Msg) {
  html.div([layout.button_style()], [
    button.new()
      |> button.variant(button_variant.Elevated)
      |> button.render([], [element.text("Elevated")]),
    button.new()
      |> button.variant(button_variant.Filled)
      |> button.render([], [element.text("Filled")]),
    button.new()
      |> button.variant(button_variant.Tonal)
      |> button.render([], [element.text("Tonal")]),
    button.new()
      |> button.variant(button_variant.Outlined)
      |> button.render([], [element.text("Outlined")]),
    button.new()
      |> button.variant(button_variant.Text)
      |> button.render([], [element.text("Text")]),
  ])
}

/// package() describes the button showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.Button,
    label: "Button",
    view: button,
    msg: msg.ButtonSelected,
  )
}
