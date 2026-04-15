import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

import m3e/button
import m3e/card
import m3e/config
import m3e/icon
import m3e/state.{Disabled}

import layout
import model
import msg.{type Msg}
import package.{type Package, Package}

/// button displays all facets of the M3E Button wrapper component
///
fn button() -> Element(Msg) {
  html.div(
    [
      layout.frame_style(),
    ],
    [
      variant(),
      shape(),
      sizes(),
      icons(),
      toggling(),
      disabling(),
      links(),
    ],
  )
}

fn sizes() -> Element(Msg) {
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
          element.text("Sizes"),
          button.new("Extra Small", button.Tonal)
            |> button.size(config.ExtraSmall)
            |> button.render([]),
          button.new("Small", button.Tonal)
            |> button.size(config.Small)
            |> button.render([]),
          button.new("Medium", button.Tonal)
            |> button.size(config.Medium)
            |> button.render([]),
          button.new("Large", button.Tonal)
            |> button.size(config.Large)
            |> button.render([]),
          button.new("Extra Large", button.Tonal)
            |> button.size(config.ExtraLarge)
            |> button.render([]),
        ],
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
        [
          element.text("Icons"),
          button.new("Send", button.Tonal)
            |> button.icons([icon.new("send") |> icon.render([], [])])
            |> button.render([]),
          button.new("Open", button.Tonal)
            |> button.icons([
              icon.new("open_in_new_window")
              |> icon.purpose(button.slot(button.TrailingIcon))
              |> icon.render([], []),
            ])
            |> button.render([]),
        ],
      ),
    ],
  )
}

fn toggling() -> Element(Msg) {
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
          element.text("Toggle"),
          button.new("Tonal toggle", button.Tonal)
            |> button.toggle(True)
            |> button.render([]),
          button.new("Start", button.Tonal)
            |> button.toggle(True)
            |> button.icons([
              icon.new("play_arrow") |> icon.render([], []),
              icon.new("stop")
                |> icon.purpose(button.slot(button.SelectedIcon))
                |> icon.render([], []),
            ])
            |> button.selected_label("Stop")
            |> button.render([]),
        ],
      ),
    ],
  )
}

fn disabling() -> Element(Msg) {
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
          element.text("Disabling"),
          button.new("Disabled", button.Filled)
            |> button.disabled(Disabled)
            |> button.render([]),
          button.new("Disabled interactive", button.Filled)
            |> button.disabled(Disabled)
            |> button.render([]),
        ],
      ),
    ],
  )
}

fn links() -> Element(Msg) {
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
          element.text("Links"),
          button.new("Google", button.Tonal)
            |> button.icons([
              icon.new("open_in_new_window")
              |> icon.purpose(button.slot(button.TrailingIcon))
              |> icon.render([], []),
            ])
            |> button.render([
              attribute.href("https://google.com"),
              attribute.target("_blank"),
            ]),
        ],
      ),
    ],
  )
}

fn shape() -> Element(Msg) {
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
          element.text("Shapes"),
          button.new("Rounded Filled", button.Filled)
            |> button.render([]),
          button.new("Square Filled", button.Filled)
            |> button.shape(button.Square)
            |> button.render([]),
        ],
      ),
    ],
  )
}

fn variant() -> Element(Msg) {
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
          element.text("Variants"),
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
    ],
  )
}

/// package() describes the button showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.Button,
    label: "Button",
    view: button,
    msg: msg.ButtonSelected,
  )
}
