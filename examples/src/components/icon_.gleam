import lustre/element.{type Element}
import lustre/element/html

import m3e/card
import m3e/icon

import layout

import msg.{type Msg}

/// icon displays all facets of the M3E Icon wrapper component
/// 
pub fn icon() -> Element(Msg) {
  html.div(
    [
      layout.frame_style(),
    ],
    [
      basic(),
      appearance(),
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
        [
          element.text("Basic"),
          icon.new("home") |> icon.render([], []),
        ],
      ),
    ],
  )
}

fn appearance() -> Element(Msg) {
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
        [
          element.text("Appearance"),
          icon.new("home")
            |> icon.variant(icon.Outlined)
            |> icon.render([], []),
          html.label([], [element.text("Outlined")]),
          icon.new("lock")
            |> icon.variant(icon.Rounded)
            |> icon.filled(icon.Filled)
            |> icon.render([], []),
          html.label([], [element.text("Rounded")]),
          icon.new("lock")
            |> icon.variant(icon.Sharp)
            |> icon.filled(icon.Filled)
            |> icon.render([], []),
          html.label([], [element.text("Sharp")]),
        ],
      ),
    ],
  )
}
