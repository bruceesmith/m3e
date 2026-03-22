import gleam/int

import lustre/attribute.{class, styles}
import lustre/element.{type Element}
import lustre/element/html

import m3e/button.{new, render}
import m3e/card
import m3e/icon
import m3e/size_many as many
import m3e/types.{Disabled}

import monks/align_items as ai
import monks/display.{grid}
import monks/gap
import monks/grid_column
import monks/grid_template_columns

// import monks/grid_template_rows

import msg.{type Msg}

pub fn button() -> Element(Msg) {
  html.div(
    [
      styles([
        grid,
        frcolumns(3),
        gapp(5),
      ]),
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

//   <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-button variant="tonal" size="extra-small">Extra Small</m3e-button>
//       <m3e-button variant="tonal" size="small">Small</m3e-button>
//       <m3e-button variant="tonal" size="medium">Medium</m3e-button>
//       <m3e-button variant="tonal" size="large">Large</m3e-button>
//       <m3e-button variant="tonal" size="extra-large">Extra Large</m3e-button>
//     </div>
//   </m3e-card>

fn sizes() -> Element(Msg) {
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
            frcolumns(6),
            ai.center,
            gapp(5),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Sizes"),
          new("Extra Small", button.Tonal)
            |> button.size(many.ExtraSmall)
            |> render([]),
          new("Small", button.Tonal)
            |> button.size(many.Small)
            |> render([]),
          new("Medium", button.Tonal)
            |> button.size(many.Medium)
            |> render([]),
          new("Large", button.Tonal)
            |> button.size(many.Large)
            |> render([]),
          new("Extra Large", button.Tonal)
            |> button.size(many.ExtraLarge)
            |> render([]),
        ],
      ),
    ],
  )
}

//   <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-button variant="tonal"><m3e-icon slot="icon" name="send"></m3e-icon>Send</m3e-button>
//       <m3e-button variant="tonal">
//         <m3e-icon slot="trailing-icon" name="open_in_new_window"></m3e-icon>Open
//       </m3e-button>
//     </div>
//   </m3e-card>

fn icons() -> Element(Msg) {
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
            frcolumns(3),
            ai.center,
            gapp(5),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Icons"),
          new("Send", button.Tonal)
            |> button.icons([icon.new("send") |> icon.render([], [])])
            |> render([class("justify-self-center")]),
          new("Open", button.Tonal)
            |> button.icons([
              icon.new("open_in_new_window")
              |> icon.purpose(button.slot(button.TrailingIcon))
              |> icon.render([], []),
            ])
            |> render([class("justify-self-center")]),
        ],
      ),
    ],
  )
}

//   <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-button variant="filled" toggle>
//         <m3e-icon slot="icon" name="play_arrow"></m3e-icon>
//         <m3e-icon slot="selected-icon" name="stop"></m3e-icon>
//         Start
//         <span slot="selected">Stop</span>
//       </m3e-button>
//     </div>
//   </m3e-card>

fn toggling() -> Element(Msg) {
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
            frcolumns(3),
            ai.center,
            gapp(5),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Toggle"),
          new("Tonal toggle", button.Tonal)
            |> button.toggle(True)
            |> render([class("justify-self-center")]),
          new("Start", button.Tonal)
            |> button.toggle(True)
            |> button.icons([
              icon.new("play_arrow") |> icon.render([], []),
              icon.new("stop")
                |> icon.purpose(button.slot(button.SelectedIcon))
                |> icon.render([], []),
            ])
            |> button.selected_label("Stop")
            |> render([class("justify-self-center")]),
        ],
      ),
    ],
  )
}

//   <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-button variant="filled" disabled>Disabled</m3e-button>
//       <m3e-button variant="filled" disabled-interactive>Disabled Interactive</m3e-button>
//     </div>
//   </m3e-card>

fn disabling() -> Element(Msg) {
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
            frcolumns(3),
            ai.center,
            gapp(5),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Disabling"),
          new("Disabled", button.Filled)
            |> button.disabled(Disabled)
            |> render([class("justify-self-center")]),
          new("Disabled interactive", button.Filled)
            |> button.disabled(Disabled)
            |> render([class("justify-self-center")]),
        ],
      ),
    ],
  )
}

//   <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-button variant="tonal" href="https://www.google.com" target="_blank">
//         Google<m3e-icon slot="trailing-icon" name="open_in_new_window"></m3e-icon>
//       </m3e-button>
//     </div>
//   </m3e-card>

fn links() -> Element(Msg) {
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
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Links"),
          new("Google", button.Tonal)
            |> button.icons([
              icon.new("open_in_new_window")
              |> icon.purpose(button.slot(button.TrailingIcon))
              |> icon.render([], []),
            ])
            |> render([
              class("justify-self-center"),
              attribute.href("https://google.com"),
              attribute.target("_blank"),
            ]),
        ],
      ),
    ],
  )
}

//   <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-button variant="elevated" shape="square">Square Elevated</m3e-button>
//       <m3e-button variant="filled" shape="square">Square Filled</m3e-button>
//       <m3e-button variant="tonal" shape="square">Square Tonal</m3e-button>
//       <m3e-button variant="outlined" shape="square">Square Outlined</m3e-button>
//       <m3e-button variant="text" shape="square">Square Text</m3e-button>
//     </div>
//   </m3e-card>

fn shape() -> Element(Msg) {
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
            frcolumns(3),
            ai.center,
            gapp(5),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Shapes"),
          new("Rounded Filled", button.Filled)
            |> render([class("justify-self-center")]),
          new("Square Filled", button.Filled)
            |> button.shape(button.Square)
            |> render([class("justify-self-center")]),
        ],
      ),
    ],
  )
}

//   <m3e-card variant="outlined">
//     <div slot="content">
//       <m3e-button variant="elevated">Elevated</m3e-button>
//       <m3e-button variant="filled">Filled</m3e-button>
//       <m3e-button variant="tonal">Tonal</m3e-button>
//       <m3e-button variant="outlined">Outlined</m3e-button>
//       <m3e-button variant="text">Text</m3e-button>
//     </div>
//   </m3e-card>

fn variant() -> Element(Msg) {
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
            frcolumns(6),
            ai.center,
            gapp(5),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Variants"),
          new("Elevated", button.Elevated)
            |> render([]),
          new("Filled", button.Filled)
            |> render([]),
          new("Tonal", button.Tonal)
            |> render([]),
          new("Outlined", button.Outlined)
            |> render([]),
          new("Text", button.Text)
            |> render([]),
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
