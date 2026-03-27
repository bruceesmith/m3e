import gleam/int
import gleam/list
import gleam/option.{Some}

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import msg.{type Msg}

import m3e/card
import m3e/state.{Checked, Disabled}
import m3e/switch

import monks/align_items
import monks/display
import monks/gap
import monks/grid_column
import monks/grid_template_columns
import monks/justify_content
import monks/padding

pub fn switch_() -> Element(Msg) {
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
      labels(),
      icons(),
      disabled(),
    ],
  )
}

// Basic usage

// <m3e-card variant="outlined">
//   <div slot="content">
//     <m3e-switch checked></m3e-switch>
//   </div>
// </m3e-card>

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
        list.flatten([
          [element.text("Basic")],
          switch.new("basic") |> switch.checked(Checked) |> switch.render([]),
        ]),
      ),
    ],
  )
}

// Labels

// <m3e-card variant="outlined">
//   <div slot="content" class="switch-box">
//     <label><m3e-switch></m3e-switch>&nbsp;Switch 1</label>
//     <m3e-switch id="switch2"></m3e-switch>
//     <label for="switch2">&nbsp;Switch 2</label>
//   </div>
// </m3e-card>

fn labels() -> Element(Msg) {
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

// Icons

//   <m3e-card variant="outlined">
//   <div slot="content" class="switch-box">
//     <m3e-switch icons="selected" checked></m3e-switch>
//     <m3e-switch icons="both"></m3e-switch>
//   </div>
// </m3e-card>

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
            gap_(5),
            pad(2),
          ]),
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

// Disabling

// <m3e-card variant="outlined">
//   <div slot="content" class="switch-box">
//     <label><m3e-switch disabled></m3e-switch>&nbsp;Disabled Switch 1</label>
//     <m3e-switch id="chk3" disabled></m3e-switch>
//     <label for="chk3">&nbsp;Disabled Switch 2</label>
//   </div>
// </m3e-card>

fn disabled() -> Element(Msg) {
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
