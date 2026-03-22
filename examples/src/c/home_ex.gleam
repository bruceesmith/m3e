import lustre/element.{type Element}
import lustre/element/html
import lustre/event.{on_click}

import msg.{type Msg, HomeSelected}

import m3e/button.{new, render}

pub fn home() -> Element(Msg) {
  html.div([], [
    new("Home", button.Outlined)
    |> render([on_click(HomeSelected)]),
  ])
}
