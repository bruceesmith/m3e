import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element.{element}

import m3e/layout.{Horizontal, Vertical}
import m3e/link
import m3e/nav_item
import m3e/types.{Disabled, Enabled, Selected, Unselected}

pub fn basic_render_test() {
  nav_item.new()
  |> nav_item.render([], [])
  |> should.equal(
    element(
      "m3e-nav-item",
      [attribute.attribute("orientation", "vertical")],
      [],
    ),
  )
}

pub fn link_property_test() {
  let test_link =
    link.new("https://example.com")
    |> link.target(link.Blank)

  nav_item.new()
  |> nav_item.link(Some(test_link))
  |> nav_item.render([], [])
  |> should.equal(
    element(
      "m3e-nav-item",
      [
        attribute.attribute("orientation", "vertical"),
        attribute.attribute("href", "https://example.com"),
        attribute.attribute("target", "_blank"),
      ],
      [],
    ),
  )
}

pub fn properties_test() {
  nav_item.new()
  |> nav_item.disabled(Disabled)
  |> nav_item.disabled_interactive(nav_item.Interactive)
  |> nav_item.selected(Selected)
  |> nav_item.orientation(Horizontal)
  |> nav_item.render([], [])
  |> should.equal(
    element(
      "m3e-nav-item",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("disabled-interactive", ""),
        attribute.attribute("selected", ""),
        attribute.attribute("orientation", "horizontal"),
      ],
      [],
    ),
  )
}

pub fn config_test() {
  let c =
    nav_item.default_config()
    |> fn(c) {
      nav_item.Config(
        ..c,
        interaction: Disabled,
        focusability: nav_item.Interactive,
        selection: Selected,
        orientation: Horizontal,
      )
    }

  let item = nav_item.from_config(c)

  nav_item.render(item, [], [])
  |> should.equal(
    element(
      "m3e-nav-item",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("disabled-interactive", ""),
        attribute.attribute("selected", ""),
        attribute.attribute("orientation", "horizontal"),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = nav_item.default_config()

  c.interaction |> should.equal(Enabled)
  c.focusability |> should.equal(nav_item.Static)
  c.selection |> should.equal(Unselected)
  c.orientation |> should.equal(Vertical)
  c.link |> should.equal(None)
}

pub fn from_config_test() {
  let c = nav_item.default_config()
  let item = nav_item.from_config(c)

  nav_item.render(item, [], [])
  |> should.equal(nav_item.render(nav_item.new(), [], []))
}

pub fn render_config_test() {
  let c = nav_item.default_config()
  let expected = nav_item.render(nav_item.from_config(c), [], [])

  nav_item.render_config(c, [], [])
  |> should.equal(expected)
}

pub fn setters_test() {
  let item =
    nav_item.new()
    |> nav_item.disabled(Disabled)
    |> nav_item.disabled_interactive(nav_item.Interactive)
    |> nav_item.selected(Selected)
    |> nav_item.orientation(Horizontal)

  nav_item.render(item, [], [])
  |> should.equal(
    element(
      "m3e-nav-item",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("disabled-interactive", ""),
        attribute.attribute("selected", ""),
        attribute.attribute("orientation", "horizontal"),
      ],
      [],
    ),
  )
}
