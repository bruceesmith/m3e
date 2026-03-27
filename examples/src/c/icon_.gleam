import gleam/int

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

import m3e/card
import m3e/icon

import monks/align_items
import monks/display
import monks/gap
import monks/grid_column
import monks/grid_template_columns
import monks/justify_content
import monks/padding

import msg.{type Msg}

pub fn icon() -> Element(Msg) {
  html.div(
    [
      attribute.styles([
        align_items.center,
        display.grid,
        frcolumns(3),
        gap_(5),
      ]),
    ],
    [
      basic(),
      appearance(),
    ],
  )
}

//  <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-icon name="home"></m3e-icon>
//     </div>
//   </m3e-card>

fn basic() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      attribute.styles([
        column(2),
        display.flex,
      ]),
    ],
    [
      html.div(
        [
          attribute.styles([
            align_items.center,
            display.flex,
            justify_content.flex_start,
            gap_(5),
            pad(2),
          ]),
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
      attribute.styles([
        column(2),
        display.flex,
      ]),
    ],
    [
      html.div(
        [
          attribute.styles([
            display.flex,
            align_items.center,
            justify_content.flex_start,
            gap_(5),
            pad(2),
          ]),
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

fn frcolumns(number: Int) -> #(String, String) {
  grid_template_columns.raw("repeat(" <> int.to_string(number) <> ", 1fr)")
}

fn gap_(g: Int) -> #(String, String) {
  gap.raw("calc(var(--spacing) * " <> int.to_string(g) <> ")")
}

fn column(c: Int) -> #(String, String) {
  grid_column.raw(int.to_string(c))
}

fn pad(p: Int) -> #(String, String) {
  padding.raw("calc(var(--spacing) * " <> int.to_string(p) <> ")")
}
