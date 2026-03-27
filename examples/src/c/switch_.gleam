import gleam/list
import gleam/option.{Some}

import lustre/element.{type Element}
import lustre/element/html

import m3e/card
import m3e/state.{Checked, Disabled}
import m3e/switch

import c/layout

import msg.{type Msg}

/// switch displays all facets of the M3E Switch wrapper component
/// 
pub fn switch_() -> Element(Msg) {
  html.div(
    [
      layout.frame_style(),
    ],
    [
      basic(),
      labels(),
      icons(),
      disabled(),
    ],
  )
}

fn basic() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      layout.card_style(),
    ],
    [
      html.div(
        [
          layout.card_content_style(),
          card.slot(card.Content),
        ],
        list.flatten([
          [element.text("Basic")],
          switch.new("basic") |> switch.checked(Checked) |> switch.render([]),
        ]),
      ),
    ],
  )
}

fn labels() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      layout.card_style(),
    ],
    [
      html.div(
        [
          layout.card_content_style(),
          card.slot(card.Content),
        ],
        list.flatten([
          [element.text("Labels")],
          switch.render_config(
            switch.Config(..switch.default_config(), label: Some("Switch 1")),
            [],
          ),
          switch.render_config(
            switch.Config(
              ..switch.default_config(),
              checked: Checked,
              label: Some("Switch 2"),
            ),
            [],
          ),
        ]),
      ),
    ],
  )
}

fn icons() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      layout.card_style(),
    ],
    [
      html.div(
        [
          layout.card_content_style(),
          card.slot(card.Content),
        ],
        list.flatten([
          [element.text("Icons")],
          switch.new("icons-none")
            |> switch.label(Some("None"))
            |> switch.icon(switch.Neither)
            |> switch.render([]),

          switch.new("icons-selected")
            |> switch.checked(Checked)
            |> switch.label(Some("Selected"))
            |> switch.icon(switch.Selected)
            |> switch.render([]),

          switch.new("icons-both")
            |> switch.label(Some("Both"))
            |> switch.icon(switch.Both)
            |> switch.render([]),
        ]),
      ),
    ],
  )
}

fn disabled() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      layout.card_style(),
    ],
    [
      html.div(
        [
          layout.card_content_style(),
          card.slot(card.Content),
        ],
        list.flatten([
          [element.text("Disabled")],
          switch.new("disabled-off")
            |> switch.label(Some("Disabled Off"))
            |> switch.disabled(Disabled)
            |> switch.render([]),
          switch.new("disabled-on")
            |> switch.label(Some("Disabled On"))
            |> switch.checked(Checked)
            |> switch.disabled(Disabled)
            |> switch.render([]),
        ]),
      ),
    ],
  )
}
