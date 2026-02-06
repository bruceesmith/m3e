import gleeunit
import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import lustre/element/html
import m3e/heading
import m3e/nav_menu_item_group

pub fn main() {
  gleeunit.main()
}

pub fn basic_render_test() {
  let heading_text = "Group Title"
  let content = [html.text("Item 1"), html.text("Item 2")]

  let expected_heading =
    heading.basic(heading_text)
    |> heading.size(heading.Large)
    |> heading.variant(heading.Label)
    |> heading.render([attribute.attribute("slot", "label")])

  nav_menu_item_group.nav_menu_item_group(heading_text)
  |> nav_menu_item_group.render([], content)
  |> should.equal(
    element("m3e-nav-menu-item-group", [], [expected_heading, ..content]),
  )
}

pub fn heading_update_test() {
  let initial = "Initial"
  let updated = "Updated"

  let expected_heading =
    heading.basic(updated)
    |> heading.size(heading.Large)
    |> heading.variant(heading.Label)
    |> heading.render([attribute.attribute("slot", "label")])

  nav_menu_item_group.nav_menu_item_group(initial)
  |> nav_menu_item_group.heading(updated)
  |> nav_menu_item_group.render([], [])
  |> should.equal(element("m3e-nav-menu-item-group", [], [expected_heading]))
}
