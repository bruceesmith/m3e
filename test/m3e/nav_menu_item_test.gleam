import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element.{element, none}
import lustre/element/html

import m3e/nav_menu_item
import m3e/state.{Disabled, Enabled, Selected, Unselected}

pub fn basic_render_test() {
  let label = "Home"
  let item = nav_menu_item.new(label)

  nav_menu_item.render(item, [])
  |> should.equal(
    element(
      "m3e-nav-menu-item",
      [attribute.none(), attribute.none(), attribute.none()],
      [
        none(),
        none(),
        html.span([attribute.attribute("slot", "label")], [html.text(label)]),
        none(),
        none(),
      ],
    ),
  )
}

pub fn properties_test() {
  let label = "Inbox"
  let badge_text = "3"

  let item =
    nav_menu_item.new(label)
    |> nav_menu_item.badge(Some(badge_text))
    |> nav_menu_item.disabled(Disabled)
    |> nav_menu_item.open(nav_menu_item.Open)
    |> nav_menu_item.selected(Selected)

  nav_menu_item.render(item, [])
  |> should.equal(
    element(
      "m3e-nav-menu-item",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("open", ""),
        attribute.attribute("selected", ""),
      ],
      [
        html.span([attribute.attribute("slot", "badge")], [
          html.text(badge_text),
        ]),
        none(),
        html.span([attribute.attribute("slot", "label")], [html.text(label)]),
        none(),
        none(),
      ],
    ),
  )
}

pub fn config_test() {
  let label = "Settings"
  let c =
    nav_menu_item.default_config(label)
    |> fn(c) {
      nav_menu_item.Config(
        ..c,
        interaction: Disabled,
        expansion: nav_menu_item.Open,
        selection: Selected,
      )
    }

  let item = nav_menu_item.from_config(c)

  nav_menu_item.render(item, [])
  |> should.equal(
    element(
      "m3e-nav-menu-item",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("open", ""),
        attribute.attribute("selected", ""),
      ],
      [
        none(),
        none(),
        html.span([attribute.attribute("slot", "label")], [html.text(label)]),
        none(),
        none(),
      ],
    ),
  )
}

pub fn default_config_test() {
  let label = "Test"
  let c = nav_menu_item.default_config(label)

  c.label |> should.equal(label)
  c.interaction |> should.equal(Enabled)
  c.expansion |> should.equal(nav_menu_item.Closed)
  c.selection |> should.equal(Unselected)
  c.badge |> should.equal(None)
}

pub fn from_config_test() {
  let label = "Test"
  let c = nav_menu_item.default_config(label)
  let item = nav_menu_item.from_config(c)

  nav_menu_item.render(item, [])
  |> should.equal(nav_menu_item.render(nav_menu_item.new(label), []))
}

pub fn render_config_test() {
  let label = "Test"
  let c = nav_menu_item.default_config(label)
  let expected = nav_menu_item.render(nav_menu_item.from_config(c), [])

  nav_menu_item.render_config(c, [])
  |> should.equal(expected)
}

pub fn setters_test() {
  let label = "Test"
  let item =
    nav_menu_item.new(label)
    |> nav_menu_item.disabled(Disabled)
    |> nav_menu_item.open(nav_menu_item.Open)
    |> nav_menu_item.selected(Selected)

  nav_menu_item.render(item, [])
  |> should.equal(
    element(
      "m3e-nav-menu-item",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("open", ""),
        attribute.attribute("selected", ""),
      ],
      [
        none(),
        none(),
        html.span([attribute.attribute("slot", "label")], [html.text(label)]),
        none(),
        none(),
      ],
    ),
  )
}
