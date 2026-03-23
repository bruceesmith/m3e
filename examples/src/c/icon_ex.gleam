import gleam/int

// import gleam/list

// import gleam/option.{Some}

import lustre/attribute.{styles}
import lustre/element.{type Element}
import lustre/element/html

// import lustre/event.{on_click}

import m3e/card
import m3e/icon.{new, render}

// import m3e/types.{Checked, Disabled}

import monks/align_items as ai
import monks/display.{grid}
import monks/gap
import monks/grid_column
import monks/grid_template_columns
import monks/padding

import msg.{type Msg}

pub fn icon() -> Element(Msg) {
  html.div(
    [
      styles([
        grid,
        frcolumns(3),
        ai.center,
        gapp(5),
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
      styles([
        column(2),
      ]),
    ],
    [
      html.div(
        [
          styles([
            grid,
            frcolumns(2),
            ai.center,
            gapp(5),
            pad(2),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Basic"),
          new("home") |> render([], []),
        ],
      ),
    ],
  )
}

fn appearance() -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      styles([
        column(2),
      ]),
    ],
    [
      html.div(
        [
          styles([
            grid,
            frcolumns(7),
            ai.center,
            gapp(5),
            pad(2),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Appearance"),
          new("home")
            |> icon.variant(icon.Outlined)
            |> render([], []),
          html.label([], [element.text("Outlined")]),
          new("lock")
            |> icon.variant(icon.Rounded)
            |> icon.filled(icon.Filled)
            |> render([], []),
          html.label([], [element.text("Rounded")]),
          new("lock")
            |> icon.variant(icon.Sharp)
            |> icon.filled(icon.Filled)
            |> render([], []),
          html.label([], [element.text("Sharp")]),
        ],
      ),
    ],
  )
}

fn frcolumns(number: Int) -> #(String, String) {
  grid_template_columns.raw("repeat(" <> int.to_string(number) <> ", 1fr)")
}

fn gapp(g: Int) -> #(String, String) {
  gap.raw("calc(var(--spacing) * " <> int.to_string(g) <> ")")
}

fn column(c: Int) -> #(String, String) {
  grid_column.raw(int.to_string(c))
}

fn pad(p: Int) -> #(String, String) {
  padding.raw("calc(var(--spacing) * " <> int.to_string(p) <> ")")
}
