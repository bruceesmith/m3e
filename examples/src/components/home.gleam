import lustre/element.{type Element}
import lustre/element/html
import lustre/event

import model
import msg.{type Msg, HomeSelected}

import m3e/button

pub fn home(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new("Home", button.Outlined)
    |> button.render([event.on_click(HomeSelected)]),
  ])
}
