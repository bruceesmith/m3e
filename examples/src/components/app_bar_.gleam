import gleam/option.{Some}

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import m3e/icon_button

import monks/align_items
import monks/display
import monks/flex_grow
import monks/height
import monks/justify_content
import monks/overflow_y
import monks/position
import monks/top

import m3e/app_bar
import m3e/card
import m3e/config
import m3e/icon

import layout
import model
import msg.{type Msg}
import package.{type Package, Package}

/// app_bar displays all facets of the M3E App Bar wrapper component
///
fn app_bar(_: model.Model) -> Element(Msg) {
  html.div(
    [
      layout.frame_style(),
    ],
    [
      anatomy(),
      sizes(),
      centered(),
      scroll_effects(),
    ],
  )
}

fn anatomy() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Elevated),
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
          element.text("Anatomy"),
          app_bar.new()
            |> app_bar.render([], content()),
        ],
      ),
    ],
  )
}

fn sizes() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Elevated),
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
          app_bar.new()
            |> app_bar.size(config.Medium)
            |> app_bar.render([], content()),
          app_bar.new()
            |> app_bar.size(config.Large)
            |> app_bar.render([], content()),
        ],
      ),
    ],
  )
}

fn centered() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Elevated),
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
          element.text("Centered"),
          app_bar.new()
            |> app_bar.centered(app_bar.Centered)
            |> app_bar.render(
              [attribute.styles([flex_grow.raw("1")])],
              content(),
            ),
        ],
      ),
    ],
  )
}

fn scroll_effects() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Elevated),
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
          element.text("Scroll"),
          html.div(
            [
              attribute.id("scrollContainer"),
              attribute.styles([
                flex_grow.raw("1"),
                overflow_y.raw("auto"),
                height.raw("300px"),
              ]),
            ],
            [
              app_bar.new()
                |> app_bar.for(Some("scrollContainer"))
                |> app_bar.render(
                  [
                    attribute.styles([
                      position.sticky,
                      top.raw("0"),
                    ]),
                  ],
                  content(),
                ),
              html.div(
                [
                  attribute.styles([
                    height.raw("400px"),
                    display.flex,
                    align_items.center,
                    justify_content.center,
                  ]),
                ],
                [element.text("Scroll down to see the elevation effect")],
              ),
            ],
          ),
        ],
      ),
    ],
  )
}

fn content() -> List(Element(Msg)) {
  [
    icon_button.new()
      |> icon_button.purpose(Some(app_bar.slot(app_bar.Leading)))
      |> icon_button.render([], [
        icon.new("arrow_back") |> icon.render([], []),
      ]),
    html.span([app_bar.slot(app_bar.Title)], [
      element.text("Top 10 hiking trails"),
    ]),
    html.span([app_bar.slot(app_bar.Subtitle)], [
      element.text("Discover popular trails"),
    ]),
    icon_button.new()
      |> icon_button.purpose(Some(app_bar.slot(app_bar.Trailing)))
      |> icon_button.render([], [
        icon.new("bookmark") |> icon.render([], []),
      ]),
  ]
}

/// package() describes the AppBar showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.AppBar,
    label: "App Bar",
    view: app_bar,
    msg: msg.AppBarPageSelected,
  )
}
