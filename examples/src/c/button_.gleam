import gleam/int

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

import m3e/button
import m3e/card
import m3e/config
import m3e/icon
import m3e/state.{Disabled}

import monks/align_items
import monks/display
import monks/gap as g
import monks/grid_column
import monks/grid_template_columns
import monks/justify_content
import monks/padding

// import monks/grid_template_rows

import msg.{type Msg}

pub fn button() -> Element(Msg) {
  html.div(
    [
      attribute.styles([
        align_items.center,
        display.grid,
        frcolumns(3),
        gap(5),
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
            gap(5),
            pad(2),
          ]),
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
            gap(5),
            pad(2),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Icons"),
          button.new("Send", button.Tonal)
            |> button.icons([icon.new("send") |> icon.render([], [])])
            |> button.render([attribute.class("justify-self-center")]),
          button.new("Open", button.Tonal)
            |> button.icons([
              icon.new("open_in_new_window")
              |> icon.purpose(button.slot(button.TrailingIcon))
              |> icon.render([], []),
            ])
            |> button.render([attribute.class("justify-self-center")]),
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
            gap(5),
            pad(2),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Toggle"),
          button.new("Tonal toggle", button.Tonal)
            |> button.toggle(True)
            |> button.render([attribute.class("justify-self-center")]),
          button.new("Start", button.Tonal)
            |> button.toggle(True)
            |> button.icons([
              icon.new("play_arrow") |> icon.render([], []),
              icon.new("stop")
                |> icon.purpose(button.slot(button.SelectedIcon))
                |> icon.render([], []),
            ])
            |> button.selected_label("Stop")
            |> button.render([attribute.class("justify-self-center")]),
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
            gap(5),
            pad(2),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Disabling"),
          button.new("Disabled", button.Filled)
            |> button.disabled(Disabled)
            |> button.render([attribute.class("justify-self-center")]),
          button.new("Disabled interactive", button.Filled)
            |> button.disabled(Disabled)
            |> button.render([attribute.class("justify-self-center")]),
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
            gap(5),
            pad(2),
          ]),
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
              attribute.class("justify-self-center"),
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
            gap(5),
            pad(2),
          ]),
          card.slot(card.Content),
        ],
        [
          element.text("Shapes"),
          button.new("Rounded Filled", button.Filled)
            |> button.render([attribute.class("justify-self-center")]),
          button.new("Square Filled", button.Filled)
            |> button.shape(button.Square)
            |> button.render([attribute.class("justify-self-center")]),
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
            gap(5),
            pad(2),
          ]),
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

fn column(c: Int) -> #(String, String) {
  grid_column.raw(int.to_string(c))
}

fn frcolumns(number: Int) -> #(String, String) {
  grid_template_columns.raw("repeat(" <> int.to_string(number) <> ", 1fr)")
}

fn gap(g: Int) -> #(String, String) {
  g.raw("calc(var(--spacing) * " <> int.to_string(g) <> ")")
}

fn pad(p: Int) -> #(String, String) {
  padding.raw("calc(var(--spacing) * " <> int.to_string(p) <> ")")
}
