import lustre/element.{type Element}
import lustre/element/html

import m3e/icon
import m3e/icon_variant

import layout
import model
import msg.{type Msg}
import package.{type Package, Package}
import view_helpers

/// icon displays all facets of the M3E Icon wrapper component
///
fn icon(model: model.Model) -> Element(Msg) {
  view_helpers.page([
    view_helpers.panel(model, "Basic", basic),
    view_helpers.panel(model, "Appearance", appearance),
  ])
}

fn basic(_: model.Model) -> Element(Msg) {
  html.div([], [
    icon.new() |> icon.name("home") |> icon.render([]),
  ])
}

fn appearance(_: model.Model) -> Element(Msg) {
  html.div([layout.icon_style()], [
    icon.new()
      |> icon.name("home")
      |> icon.variant(icon_variant.Outlined)
      |> icon.render([]),
    html.label([], [element.text("Outlined")]),
    icon.new()
      |> icon.name("lock")
      |> icon.variant(icon_variant.Rounded)
      |> icon.filled(icon.IsFilled)
      |> icon.render([]),
    html.label([], [element.text("Rounded")]),
    icon.new()
      |> icon.name("lock")
      |> icon.variant(icon_variant.Sharp)
      |> icon.filled(icon.IsFilled)
      |> icon.render([]),
    html.label([], [element.text("Sharp")]),
  ])
}

/// package() describes the icon showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.Icon,
    label: "Icon",
    view: icon,
    msg: msg.IconPageSelected,
  )
}
