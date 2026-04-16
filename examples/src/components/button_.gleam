import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

import m3e/button
import m3e/config
import m3e/icon
import m3e/state.{Disabled}

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
  html.div([], [
    button.new("Extra Small", button.Tonal)
      |> button.size(config.ExtraSmall)
      |> button.render([]),
    button.new("Small", button.Tonal)
      |> button.size(config.Small)
      |> button.render([]),
    button.new("Medium", button.Tonal)
      |> button.size(config.Medium)
      |> button.render([]),
    button.new("Large", button.Tonal)
      |> button.size(config.Large)
      |> button.render([]),
    button.new("Extra Large", button.Tonal)
      |> button.size(config.ExtraLarge)
      |> button.render([]),
  ])
}

fn icons(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new("Send", button.Tonal)
      |> button.icons([icon.new("send") |> icon.render([], [])])
      |> button.render([]),
    button.new("Open", button.Tonal)
      |> button.icons([
        icon.new("open_in_new_window")
        |> icon.purpose(button.slot(button.TrailingIcon))
        |> icon.render([], []),
      ])
      |> button.render([]),
  ])
}

fn toggling(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new("Tonal toggle", button.Tonal)
      |> button.toggle(True)
      |> button.render([]),
    button.new("Start", button.Tonal)
      |> button.toggle(True)
      |> button.icons([
        icon.new("play_arrow") |> icon.render([], []),
        icon.new("stop")
          |> icon.purpose(button.slot(button.SelectedIcon))
          |> icon.render([], []),
      ])
      |> button.selected_label("Stop")
      |> button.render([]),
  ])
}

fn disabling(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new("Disabled", button.Filled)
      |> button.disabled(Disabled)
      |> button.render([]),
    button.new("Disabled interactive", button.Filled)
      |> button.disabled(Disabled)
      |> button.render([]),
  ])
}

fn links(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new("Google", button.Tonal)
    |> button.icons([
      icon.new("open_in_new_window")
      |> icon.purpose(button.slot(button.TrailingIcon))
      |> icon.render([], []),
    ])
    |> button.render([
      attribute.href("https://google.com"),
      attribute.target("_blank"),
    ]),
  ])
}

fn shape(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new("Rounded Filled", button.Filled)
      |> button.render([]),
    button.new("Square Filled", button.Filled)
      |> button.shape(button.Square)
      |> button.render([]),
  ])
}

fn variant(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new("Elevated", button.Elevated)
      |> button.render([]),
    button.new("Filled", button.Filled)
      |> button.render([]),
    button.new("Tonal", button.Tonal)
      |> button.render([]),
    button.new("Outlined", button.Outlined)
      |> button.render([]),
    button.new("Text", button.Text)
      |> button.render([]),
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
