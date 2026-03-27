//// view constructs the HTML for the SPA

import gleam/option.{Some}
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

import layout
import model.{type Model}
import msg.{type Msg, ButtonPageSelected, IconPageSelected, SwitchPageSelected}

import m3e/app_bar
import m3e/drawer_container
import m3e/drawer_toggle
import m3e/helpers
import m3e/icon
import m3e/icon_button
import m3e/link
import m3e/nav_menu
import m3e/nav_menu_item
import m3e/state.{Selected}
import m3e/theme
import m3e/tooltip

import c/button_
import c/home
import c/icon_
import c/switch_

pub fn view(model: Model) -> Element(Msg) {
  let content = case model.state {
    model.Home -> home.home()
    model.Button -> button_.button()
    model.Icon -> icon_.icon()
    model.Switch -> switch_.switch_()
  }

  theme.render(
    theme.new("app-theme")
      |> theme.contrast(theme.High)
      |> theme.scheme(theme.Auto),
    [],
    [
      appbar(),
      body(content),
    ],
  )
}

fn appbar() -> Element(Msg) {
  app_bar.new()
  |> app_bar.for(Some("main-content"))
  |> app_bar.render([layout.app_bar_style()], [
    icon_button.new()
      |> icon_button.purpose(Some(app_bar.slot(app_bar.LeadingIcon)))
      |> icon_button.selected(Selected)
      |> icon_button.toggle(icon_button.Toggle)
      |> icon_button.render([], [
        icon.new("menu") |> icon.filled(icon.Filled) |> icon.render([], []),
        icon.new("menu_open")
          |> icon.filled(icon.Filled)
          |> icon.purpose(icon_button.slot(icon_button.SelectedIcon))
          |> icon.render([], []),
        drawer_toggle.new("nav-drawer") |> drawer_toggle.render([], []),
      ]),
    html.span(
      [
        app_bar.slot(app_bar.Title),
        layout.app_bar_title_style(),
      ],
      [
        element.text("Gleam/Lustre Material 3 Expression demonstration"),
      ],
    ),
    html.span(
      [
        app_bar.slot(app_bar.Subtitle),
        layout.app_bar_title_style(),
      ],
      [element.text("v0.0.1")],
    ),
    html.span([app_bar.slot(app_bar.TrailingIcon)], [
      icon_button.new()
        |> icon_button.link(
          Some(link.new("https://github.com/bruceesmith/m3e")),
        )
        |> icon_button.render([attribute.id("github-button")], [
          github(),
        ]),

      tooltip.new("Github", "github-button") |> tooltip.render([]),
    ]),
  ])
}

fn body(content: Element(Msg)) -> Element(Msg) {
  drawer_container.render_config(
    drawer_container.Config(
      ..drawer_container.default_config(),
      main_content: content,
      start_drawer: Some(menu()),
      start: drawer_container.Open,
      start_mode: drawer_container.Auto,
    ),
    [],
  )
}

fn github() -> Element(Msg) {
  html.img([
    attribute.attribute(
      "src",
      "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
    ),
    attribute.attribute("alt", "GitHub"),
    attribute.attribute("height", "40"),
    attribute.attribute("width", "40"),
  ])
}

fn menu() -> Element(Msg) {
  nav_menu.new()
  |> nav_menu.render([attribute.id("nav-drawer"), helpers.slot("start")], [
    nav_menu_item.new("Button")
      |> nav_menu_item.render([
        event.on_click(ButtonPageSelected),
        attribute.id("m3e-nav-menu-item-1"),
      ]),
    nav_menu_item.new("Icon")
      |> nav_menu_item.render([
        event.on_click(IconPageSelected),
        attribute.id("m3e-nav-menu-item-2"),
      ]),
    nav_menu_item.new("Switch")
      |> nav_menu_item.render([
        event.on_click(SwitchPageSelected),
        attribute.id("m3e-nav-menu-item-3"),
      ]),
  ])
}
