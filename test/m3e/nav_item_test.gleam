import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import m3e/link
import m3e/nav_item

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
  |> nav_item.disabled(True)
  |> nav_item.disabled_interactive(True)
  |> nav_item.selected(True)
  |> nav_item.orientation(nav_item.Horizontal)
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
