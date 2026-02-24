//// view constructs the HTML for the SPA

import gleam/option.{Some}
import lustre/attribute.{attribute, class}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event.{on_click}
import model.{type Model, Home, Icon, Switch}
import msg.{
  type Msg, ButtonPageSelected, HomeSelected, IconPageSelected,
  SwitchPageSelected,
}

import m3e/button
import m3e/card
import m3e/drawer
import m3e/drawer_container as dc
import m3e/drawer_toggle
import m3e/icon
import m3e/icon_button as ib
import m3e/switch
import m3e/theme

// <m3e-icon-button slot="leading-icon" aria-label="Menu" toggle>
//   <m3e-icon name="menu"></m3e-icon>
//   <m3e-icon slot="selected" name="menu_open"></m3e-icon>
//   <m3e-drawer-toggle for="nav-drawer"></m3e-drawer-toggle>
// </m3e-icon-button>

pub fn view(model: Model) -> Element(Msg) {
  // let nav =
  //   html.div([attribute("slot", "start"), id("nav-drawer")], [
  //     html.text("Start drawer"),
  //   ])
  let main = case model.state {
    Home -> home()
    model.Button -> button()
    Icon -> icon()
    Switch -> switch_()
  }
  let title =
    html.div([class("grid justify-center")], [
      html.text("Gleam/Lustre Material 3 Expression demonstration"),
    ])
  let body = [
    card.new()
    |> card.variant(card.Outlined)
    |> card.render([], [
      html.div([attribute("slot", "content")], [
        ib.new()
          |> ib.toggle(True)
          |> ib.purpose(Some(ib.LeadingIcon))
          |> ib.variant(ib.Filled)
          |> ib.render([], [
            icon.new("menu") |> icon.render([], []),
            icon.new("menu_open")
              |> icon.purpose(icon.SelectedIcon)
              |> icon.render([], []),
            drawer_toggle.new("nav-drawer")
              |> drawer_toggle.render([], []),
          ]),
        dc.new()
          |> dc.start(
            drawer.new()
            |> drawer.usage(drawer.Start)
            |> drawer.mode(drawer.Over)
            |> drawer.open(True)
            |> drawer.id("nav-drawer")
            |> drawer.divider(False)
            |> drawer.content(html.text("Start drawer")),
          )
          |> dc.end(drawer.empty())
          |> dc.render([], [main]),
        // drawer-container
      ]),
    ]),
  ]
  theme.render(
    theme.new("app-theme") |> theme.color("#09022e"),
    // [class("grid gap-5")],
    [],
    [title, ..body],
  )
}

fn home() -> Element(Msg) {
  html.div([], [
    html.text("home"),
    html.br([]),
    html.div([on_click(ButtonPageSelected)], [html.text("Button")]),
    html.br([]),
    html.div([on_click(IconPageSelected)], [html.text("Icon")]),
    html.br([]),
    html.div([on_click(SwitchPageSelected)], [html.text("Switch")]),
  ])
}

fn button() -> Element(Msg) {
  html.div(
    [
      class("grid grid-cols-[5fr_5fr_5fr] gap-5"),
    ],
    [
      button.new("Home", button.Outlined)
        |> button.render([class("col-2"), on_click(HomeSelected)]),
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
              |> icon.purpose(icon.Trailing)
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
                |> icon.purpose(icon.SelectedIcon)
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
              |> icon.purpose(icon.Trailing)
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

fn icon() -> Element(Msg) {
  html.div([], [
    html.div([on_click(HomeSelected)], [html.text("Home")]),
    html.br([]),
    html.div([], [icon.new("home") |> icon.render([], [])]),
    html.br([]),
  ])
}

fn switch_() -> Element(Msg) {
  html.div([], [
    html.div([on_click(HomeSelected)], [html.text("Home")]),
    html.br([]),
    html.div([], switch.new("my-switch", "My choice") |> switch.render([])),
    html.br([]),
  ])
}
