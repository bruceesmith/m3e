import lustre/element.{type Element}
import lustre/element/html
import lustre/event

import msg.{type Msg, HomeSelected}

import m3e/button

pub fn home() -> Element(Msg) {
  html.div([], [
    button.new("Home", button.Outlined)
    |> button.render([event.on_click(HomeSelected)]),
  ])
}
