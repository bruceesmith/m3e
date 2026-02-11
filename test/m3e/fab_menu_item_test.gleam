import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/fab_menu_item
import m3e/link

pub fn basic_test() {
  let item = fab_menu_item.new()

  let expected = element("m3e-fab-menu-item", [], [])

  fab_menu_item.render(item, [], [])
  |> should.equal(expected)
}

pub fn disabled_test() {
  let item =
    fab_menu_item.new()
    |> fab_menu_item.disabled(True)

  let expected = element("m3e-fab-menu-item", [attribute.disabled(True)], [])

  fab_menu_item.render(item, [], [])
  |> should.equal(expected)
}

pub fn link_test() {
  let l = link.new("https://example.com")
  let item =
    fab_menu_item.new()
    |> fab_menu_item.link(Some(l))

  let expected =
    element(
      "m3e-fab-menu-item",
      [
        attribute("href", "https://example.com"),
        attribute("target", "_self"),
      ],
      [],
    )

  fab_menu_item.render(item, [], [])
  |> should.equal(expected)
}

pub fn children_test() {
  let item = fab_menu_item.new()
  let child = element.text("Item Label")

  let expected = element("m3e-fab-menu-item", [], [child])

  fab_menu_item.render(item, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let item = fab_menu_item.new()
  let attr = attribute("custom", "value")

  let expected = element("m3e-fab-menu-item", [attr], [])

  fab_menu_item.render(item, [attr], [])
  |> should.equal(expected)
}
