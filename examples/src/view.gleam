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
import m3e/drawer.{drawer}
import m3e/drawer_container.{drawer_container} as dc
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
    card.basic()
    |> card.variant(card.Outlined)
    |> card.element([], [
      html.div([attribute("slot", "content")], [
        ib.basic()
          |> ib.toggle(True)
          |> ib.purpose(Some(ib.LeadingIcon))
          |> ib.variant(ib.Filled)
          |> ib.element([], [
            icon.basic("menu") |> icon.element([], []),
            icon.basic("menu_open")
              |> icon.purpose(icon.Selected)
              |> icon.element([], []),
            drawer_toggle.drawer_toggle("nav-drawer")
              |> drawer_toggle.element([], []),
          ]),
        drawer_container(
          drawer(
            drawer.Start,
            drawer.Over,
            True,
            "nav-drawer",
            False,
            html.text("Start drawer"),
          ),
          main,
          drawer.empty(),
        )
          |> dc.element([]),
        // drawer-container
      ]),
    ]),
  ]
  theme.element(
    theme.basic("app-theme") |> theme.color("#09022e"),
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
      button.basic("Home", button.Outlined)
        |> button.element([class("col-2"), on_click(HomeSelected)]),
      html.div(
        [
          class(
            "grid grid-rows-1 grid-cols-[1fr_1fr_1fr_1fr_1fr_1fr] items-center  gap-5 col-2",
          ),
        ],
        [
          html.p([], [html.text("Variants")]),
          button.basic("Elevated", button.Elevated)
            |> button.element([]),
          button.basic("Filled", button.Filled)
            |> button.element([]),
          button.basic("Tonal", button.Tonal)
            |> button.element([]),
          button.basic("Outlined", button.Outlined)
            |> button.element([]),
          button.basic("Text", button.Text)
            |> button.element([]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center  gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Shapes")]),
          button.basic("Rounded Filled", button.Filled)
            |> button.element([class("justify-self-center")]),
          button.basic("Square Filled", button.Filled)
            |> button.shape(button.Square)
            |> button.element([class("justify-self-center")]),
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
          button.basic("Extra Small", button.Tonal)
            |> button.size(button.ExtraSmall)
            |> button.element([]),
          button.basic("Small", button.Tonal)
            |> button.size(button.Small)
            |> button.element([]),
          button.basic("Medium", button.Tonal)
            |> button.size(button.Medium)
            |> button.element([]),
          button.basic("Large", button.Tonal)
            |> button.size(button.Large)
            |> button.element([]),
          button.basic("Extra Large", button.Tonal)
            |> button.size(button.ExtraLarge)
            |> button.element([]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Icons")]),
          button.basic("Send", button.Tonal)
            |> button.icons([icon.basic("send") |> icon.element([], [])])
            |> button.element([class("justify-self-center")]),
          button.basic("Open", button.Tonal)
            |> button.icons([
              icon.basic("open_in_new_window")
              |> icon.purpose(icon.Trailing)
              |> icon.element([], []),
            ])
            |> button.element([class("justify-self-center")]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Toggle")]),
          button.basic("Tonal toggle", button.Tonal)
            |> button.toggle(True)
            |> button.element([class("justify-self-center")]),
          button.basic("Start", button.Tonal)
            |> button.toggle(True)
            |> button.icons([
              icon.basic("play_arrow") |> icon.element([], []),
              icon.basic("stop")
                |> icon.purpose(icon.Selected)
                |> icon.element([], []),
            ])
            |> button.selected_label("Stop")
            |> button.element([class("justify-self-center")]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Disabling")]),
          button.basic("Disabled", button.Filled)
            |> button.disabled(True)
            |> button.element([class("justify-self-center")]),
          button.basic("Disabled interactive", button.Filled)
            |> button.disabled(True)
            |> button.element([class("justify-self-center")]),
        ],
      ),
      html.div(
        [
          class("grid grid-rows-1 grid-cols-4 items-center gap-5 col-2"),
        ],
        [
          html.p([], [html.text("Links")]),
          button.basic("Google", button.Tonal)
            |> button.icons([
              icon.basic("open_in_new_window")
              |> icon.purpose(icon.Trailing)
              |> icon.element([], []),
            ])
            |> button.element([
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
    html.div([], [icon.basic("home") |> icon.element([], [])]),
    html.br([]),
  ])
}

fn switch_() -> Element(Msg) {
  html.div([], [
    html.div([on_click(HomeSelected)], [html.text("Home")]),
    html.br([]),
    html.div([], switch.basic("my-switch", "My choice") |> switch.element([])),
    html.br([]),
  ])
}
