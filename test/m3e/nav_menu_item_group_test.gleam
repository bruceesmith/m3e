import gleeunit/should

import lustre/attribute
import lustre/element
import lustre/element/html

import m3e/config
import m3e/heading
import m3e/nav_menu_item_group

pub fn basic_render_test() {
  let heading_text = "Group Title"
  let content = [html.text("Item 1"), html.text("Item 2")]

  let expected_heading =
    heading.new(heading_text)
    |> heading.size(config.Large)
    |> heading.variant(heading.Label)
    |> heading.render([attribute.attribute("slot", "group-label")])

  nav_menu_item_group.new(heading_text)
  |> nav_menu_item_group.render([], content)
  |> should.equal(
    element.element("m3e-nav-menu-item-group", [], [expected_heading, ..content]),
  )
}

pub fn heading_update_test() {
  let initial = "Initial"
  let updated = "Updated"

  let expected_heading =
    heading.new(updated)
    |> heading.size(config.Large)
    |> heading.variant(heading.Label)
    |> heading.render([attribute.attribute("slot", "group-label")])

  nav_menu_item_group.new(initial)
  |> nav_menu_item_group.heading(updated)
  |> nav_menu_item_group.render([], [])
  |> should.equal(
    element.element("m3e-nav-menu-item-group", [], [expected_heading]),
  )
}
