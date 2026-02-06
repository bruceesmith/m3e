import gleam/option
import gleeunit
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/nav_menu_item

pub fn main() {
  gleeunit.main()
}

pub fn basic_render_test() {
  let label = "Home"
  let item =
    nav_menu_item.nav_menu_item(
      option.None,
      False,
      option.None,
      label,
      False,
      False,
      option.None,
      option.None,
    )

  nav_menu_item.element(item, [])
  |> should.equal(
    element.element(
      "m3e-nav-menu-item",
      [attribute.none(), attribute.none(), attribute.none()],
      [
        element.none(),
        element.none(),
        html.span([attribute.attribute("slot", "label")], [html.text(label)]),
        element.none(),
        element.none(),
      ],
    ),
  )
}

pub fn properties_test() {
  let label = "Inbox"
  let badge_text = "3"

  let item =
    nav_menu_item.nav_menu_item(
      option.None,
      False,
      option.None,
      label,
      False,
      False,
      option.None,
      option.None,
    )
    |> nav_menu_item.badge(option.Some(badge_text))
    |> nav_menu_item.disabled(True)
    |> nav_menu_item.open(True)
    |> nav_menu_item.selected(True)

  nav_menu_item.element(item, [])
  |> should.equal(
    element.element(
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
        element.none(),
        html.span([attribute.attribute("slot", "label")], [html.text(label)]),
        element.none(),
        element.none(),
      ],
    ),
  )
}
