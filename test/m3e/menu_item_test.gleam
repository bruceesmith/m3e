import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/link
import m3e/menu_item

pub fn basic_test() {
  let m = menu_item.new()

  let expected = element.element("m3e-menu-item", [], [])

  menu_item.render(m, [], [])
  |> should.equal(expected)
}

pub fn disabled_test() {
  let m =
    menu_item.new()
    |> menu_item.disabled(True)

  let expected =
    element.element("m3e-menu-item", [attribute.attribute("disabled", "")], [])

  menu_item.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item.disabled(False)

  let expected2 = element.element("m3e-menu-item", [], [])

  menu_item.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn link_test() {
  let l = link.new("https://example.com")
  let m =
    menu_item.new()
    |> menu_item.link(Some(l))

  let expected =
    element.element(
      "m3e-menu-item",
      [
        attribute.attribute("href", "https://example.com"),
        attribute.attribute("target", "_self"),
      ],
      [],
    )

  menu_item.render(m, [], [])
  |> should.equal(expected)
}

pub fn children_test() {
  let m = menu_item.new()
  let child = element.element("span", [], [])

  let expected = element.element("m3e-menu-item", [], [child])

  menu_item.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = menu_item.new()
  let attr = attribute.attribute("class", "custom")

  let expected = element.element("m3e-menu-item", [attr], [])

  menu_item.render(m, [attr], [])
  |> should.equal(expected)
}
