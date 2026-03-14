//// view constructs the HTML for the SPA

import gleam/option.{Some}
import lustre/attribute.{attribute, class, id}
import lustre/element.{type Element, text}
import lustre/element/html
import lustre/event.{on_click}
import model.{type Model}
import msg.{
  type Msg, ButtonPageSelected, HomeSelected, IconPageSelected,
  SwitchPageSelected,
}

import m3e/app_bar
import m3e/button

// import m3e/card
import m3e/drawer_container as dc

import m3e/drawer_toggle as dt
import m3e/helpers.{slot}
import m3e/icon
import m3e/icon_button as ib
import m3e/link
import m3e/nav_menu
import m3e/nav_menu_item
import m3e/switch
import m3e/theme
import m3e/tooltip

pub fn view(model: Model) -> Element(Msg) {
  let github =
    html.img([
      attribute(
        "src",
        "https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png",
      ),
      attribute("alt", "GitHub"),
      attribute("height", "40"),
      attribute("width", "40"),
    ])
  let appbar =
    app_bar.new()
    |> app_bar.for(Some("main-content"))
    |> app_bar.render([class("flex-none z-4")], [
      ib.new()
        |> ib.purpose(Some(app_bar.slot(app_bar.LeadingIcon)))
        |> ib.selected(True)
        |> ib.toggle(True)
        |> ib.render([], [
          icon.new("menu") |> icon.filled(True) |> icon.render([], []),
          icon.new("menu_open")
            |> icon.filled(True)
            |> icon.purpose(ib.slot(ib.Selected))
            |> icon.render([], []),
          dt.new("nav-drawer") |> dt.render([], []),
        ]),
      html.span([slot("title")], [
        text("Gleam/Lustre Material 3 Expression demonstration"),
      ]),
      html.span([slot("subtitle")], [text("v0.0.1")]),
      html.span([slot("trailing-icon")], [
        ib.new()
          |> ib.link(Some(link.new("https://github.com/bruceesmith/m3e")))
          |> ib.render([id("github-button")], [
            github,
          ]),

        tooltip.new("Github", "github-button") |> tooltip.render([]),
      ]),
    ])

  let menu =
    nav_menu.new()
    |> nav_menu.render([id("nav-drawer"), slot("start")], [
      nav_menu_item.new("Button")
        |> nav_menu_item.render([
          event.on_click(ButtonPageSelected),
          id("m3e-nav-menu-item-1"),
        ]),
      nav_menu_item.new("Icon")
        |> nav_menu_item.render([
          event.on_click(IconPageSelected),
          id("m3e-nav-menu-item-2"),
        ]),
      nav_menu_item.new("Switch")
        |> nav_menu_item.render([
          event.on_click(SwitchPageSelected),
          id("m3e-nav-menu-item-3"),
        ]),
    ])

  let content = case model.state {
    model.Home -> home()
    model.Button -> button()
    model.Icon -> icon()
    model.Switch -> switch_()
  }

  let drawercontainer =
    dc.render_config(
      dc.Config(
        ..dc.default_config(),
        main_content: content,
        start_drawer: Some(menu),
        start: True,
        start_mode: dc.Auto,
      ),
      [],
    )

  theme.render(
    theme.new("app-theme")
      |> theme.contrast(theme.High)
      |> theme.scheme(theme.Auto),
    [],
    [
      appbar,
      drawercontainer,
    ],
  )
}

pub fn home() -> Element(Msg) {
  html.div([], [
    button.new("Home", button.Outlined)
    |> button.render([on_click(HomeSelected)]),
  ])
}

pub fn button() -> Element(Msg) {
  html.div(
    [
      class("grid grid-cols-[5fr_5fr_5fr] gap-5"),
    ],
    [
      // button.new("Home", button.Outlined)
      //   |> button.render([class("col-2"), on_click(HomeSelected)]),
      html.div(
        [
          class(
            "grid grid-rows-1 grid-cols-[1fr_1fr_1fr_1fr_1fr_1fr] items-center  gap-5 col-2",
          ),
        ],
        [
          html.p([], [html.text("Variants")]),
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
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center  gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Shapes")]),
          button.new("Rounded Filled", button.Filled)
            |> button.render([class("justify-self-center")]),
          button.new("Square Filled", button.Filled)
            |> button.shape(button.Square)
            |> button.render([class("justify-self-center")]),
        ],
      ),
      html.div(
        [
          class(
            "grid grid-rows-1 grid-cols-[1fr_1fr_1fr_1fr_1fr_1fr] items-center gap-5 col-2",
          ),
        ],
        [
          html.p([], [html.text("Sizes")]),
          button.new("Extra Small", button.Tonal)
            |> button.size(button.ExtraSmall)
            |> button.render([]),
          button.new("Small", button.Tonal)
            |> button.size(button.Small)
            |> button.render([]),
          button.new("Medium", button.Tonal)
            |> button.size(button.Medium)
            |> button.render([]),
          button.new("Large", button.Tonal)
            |> button.size(button.Large)
            |> button.render([]),
          button.new("Extra Large", button.Tonal)
            |> button.size(button.ExtraLarge)
            |> button.render([]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Icons")]),
          button.new("Send", button.Tonal)
            |> button.icons([icon.new("send") |> icon.render([], [])])
            |> button.render([class("justify-self-center")]),
          button.new("Open", button.Tonal)
            |> button.icons([
              icon.new("open_in_new_window")
              |> icon.purpose(button.slot(button.TrailingIcon))
              |> icon.render([], []),
            ])
            |> button.render([class("justify-self-center")]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Toggle")]),
          button.new("Tonal toggle", button.Tonal)
            |> button.toggle(True)
            |> button.render([class("justify-self-center")]),
          button.new("Start", button.Tonal)
            |> button.toggle(True)
            |> button.icons([
              icon.new("play_arrow") |> icon.render([], []),
              icon.new("stop")
                |> icon.purpose(button.slot(button.SelectedIcon))
                |> icon.render([], []),
            ])
            |> button.selected_label("Stop")
            |> button.render([class("justify-self-center")]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Disabling")]),
          button.new("Disabled", button.Filled)
            |> button.disabled(True)
            |> button.render([class("justify-self-center")]),
          button.new("Disabled interactive", button.Filled)
            |> button.disabled(True)
            |> button.render([class("justify-self-center")]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Links")]),
          button.new("Google", button.Tonal)
            |> button.icons([
              icon.new("open_in_new_window")
              |> icon.purpose(button.slot(button.TrailingIcon))
              |> icon.render([], []),
            ])
            |> button.render([
              class("justify-self-center"),
              attribute.href("https://google.com"),
              attribute.target("_blank"),
            ]),
        ],
      ),
    ],
  )
}

pub fn icon() -> Element(Msg) {
  html.div([], [
    html.div([on_click(HomeSelected)], [html.text("Home")]),
    html.br([]),
    html.div([], [icon.new("home") |> icon.render([], [])]),
    html.br([]),
  ])
}

pub fn switch_() -> Element(Msg) {
  html.div([], [
    html.div([on_click(HomeSelected)], [html.text("Home")]),
    html.br([]),
    html.div([], switch.new("my-switch", "My choice") |> switch.render([])),
    html.br([]),
  ])
}
