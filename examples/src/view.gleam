//// view constructs the HTML for the SPA

import gleam/list
import gleam/option.{Some}
import gleam/result
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

import m3e/app_bar
import m3e/drawer_container
import m3e/drawer_toggle
import m3e/icon
import m3e/icon_button
import m3e/link
import m3e/nav_menu
import m3e/nav_menu_item
import m3e/state.{Selected}
import m3e/theme
import m3e/tooltip

import components/app_bar_
import components/button_
import components/home
import components/icon_
import components/switch_
import layout
import model.{type Model}
import msg.{type Msg}
import package.{type Package}

/// view is the display member of the model-view-update triumvirate (The Elm Architecture)
/// view takes the model, as updated by update(), and renders HTML from it
/// 
pub fn view(model: Model) -> Element(Msg) {
  theme.render(
    theme.new("app-theme")
      |> theme.contrast(theme.High)
      |> theme.scheme(theme.Auto),
    [],
    [
      appbar(),
      body(content(model.state)),
    ],
  )
}

/// appbar builds the top application bar
/// 
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

/// body builds the overall page body
/// 
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

/// content builds the variable content, the "start drawer", of the page. content() represents a
/// compromise between succinctness of code (the use of list.find()) and total type safety (where
/// a giant case statement exhaustively matches model.state with a component-specific function)
/// 
fn content(state: model.State) -> Element(Msg) {
  list.find(packages(), fn(p) { p.state == state })
  |> result.map(fn(p) { p.view() })
  |> result.unwrap(home.home())
}

/// github builds the Github link
/// 
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

/// menu builds the left-side navigation menu
///
fn menu() -> Element(Msg) {
  nav_menu.new()
  |> nav_menu.render(
    [attribute.id("nav-drawer"), drawer_container.slot(drawer_container.Start)],
    nav_menu_items(),
  )
}

/// nav_menu_items builds the left-side navigation menu items
/// 
fn nav_menu_items() -> List(Element(Msg)) {
  list.map(packages(), fn(package) -> Element(Msg) {
    nav_menu_item.new(package.label)
    |> nav_menu_item.render([
      event.on_click(package.msg),
    ])
  })
}

/// packages provides the "source of truth" for the components that are displayed in the
/// showcase. It both simplifies and standardises the addition of new components. It is used 
/// by nav_men_items to construct the left-side navigation menu, and by content() to build
/// the variable section of the page
/// 
fn packages() -> List(Package) {
  [
    app_bar_.package(),
    button_.package(),
    icon_.package(),
    switch_.package(),
  ]
}
