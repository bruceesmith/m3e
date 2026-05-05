import lustre/element.{type Element}
import lustre/element/html
import lustre/event

import model
import msg.{type Msg, HomeSelected}

import m3e/button
import m3e/button_variant

pub fn home(_: model.Model) -> Element(Msg) {
  html.div([], [
    button.new()
    |> button.variant(button_variant.Outlined)
    |> button.render([event.on_click(HomeSelected)], [element.text("Home")]),
  ])
}
