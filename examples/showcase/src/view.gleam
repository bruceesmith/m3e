//// view constructs the HTML for the SPA

import gleam/option.{None, Some}

// import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import lustre/event.{on_click}
import model.{type Model, Home, Icon, Switch}
import msg.{
  type Msg, ButtonPageSelected, HomeSelected, IconPageSelected,
  SwitchPageSelected,
}

import m3e/button
import m3e/icon
import m3e/switch
import m3e/theme

pub fn view(model: Model) -> Element(Msg) {
  let body = case model.state {
    Home -> home()
    model.Button -> button()
    Icon -> icon()
    Switch -> switch_()
  }
  let title = html.text("M3E demonstration")
  // html.div([class("light")], [title, body])
  theme.element(theme.basic(None) |> theme.color(Some("#34eb67")), [
    title,
    body,
  ])
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
  html.div([], [
    html.div([on_click(HomeSelected)], [html.text("Home")]),
    html.br([]),
    html.div([], [
      button.basic("One")
      |> button.element([]),
    ]),
    html.br([]),
  ])
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
