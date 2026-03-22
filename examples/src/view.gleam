//// view constructs the HTML for the SPA

import gleam/option.{Some}
import lustre/attribute.{attribute, class, id}
import lustre/element.{type Element, text}
import lustre/element/html
import lustre/event.{on_click}

import model.{type Model}
import msg.{type Msg, ButtonPageSelected, IconPageSelected, SwitchPageSelected}

import m3e/app_bar
import m3e/drawer_container
import m3e/drawer_toggle as dt
import m3e/helpers.{slot}
import m3e/icon
import m3e/icon_button
import m3e/link
import m3e/nav_menu
import m3e/nav_menu_item
import m3e/theme
import m3e/tooltip
import m3e/types.{Selected}

import c/button_ex.{button as btn}
import c/home_ex.{home}
import c/icon_ex.{icon as ico}
import c/switch_ex.{switch_ as switch_}

pub fn view(model: Model) -> Element(Msg) {
  let content = case model.state {
    model.Home -> home()
    model.Button -> btn()
    model.Icon -> ico()
    model.Switch -> switch_()
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
  |> app_bar.render([class("flex-none z-4")], [
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
        dt.new("nav-drawer") |> dt.render([], []),
      ]),
    html.span([slot("title")], [
      text("Gleam/Lustre Material 3 Expression demonstration"),
    ]),
    html.span([slot("subtitle")], [text("v0.0.1")]),
    html.span([slot("trailing-icon")], [
      icon_button.new()
        |> icon_button.link(
          Some(link.new("https://github.com/bruceesmith/m3e")),
        )
        |> icon_button.render([id("github-button")], [
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
    attribute(
      "src",
      "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
    ),
    attribute("alt", "GitHub"),
    attribute("height", "40"),
    attribute("width", "40"),
  ])
}

fn menu() -> Element(Msg) {
  nav_menu.new()
  |> nav_menu.render([id("nav-drawer"), slot("start")], [
    nav_menu_item.new("Button")
      |> nav_menu_item.render([
        on_click(ButtonPageSelected),
        id("m3e-nav-menu-item-1"),
      ]),
    nav_menu_item.new("Icon")
      |> nav_menu_item.render([
        on_click(IconPageSelected),
        id("m3e-nav-menu-item-2"),
      ]),
    nav_menu_item.new("Switch")
      |> nav_menu_item.render([
        on_click(SwitchPageSelected),
        id("m3e-nav-menu-item-3"),
      ]),
  ])
}
