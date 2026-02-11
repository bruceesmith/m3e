import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/link
import m3e/menu_item

pub fn basic_test() {
  let m = menu_item.new()

  let expected = element("m3e-menu-item", [], [])

  menu_item.render(m, [], [])
  |> should.equal(expected)
}

pub fn disabled_test() {
  let m =
    menu_item.new()
    |> menu_item.disabled(True)

  let expected = element("m3e-menu-item", [attribute("disabled", "")], [])

  menu_item.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item.disabled(False)

  let expected2 = element("m3e-menu-item", [], [])

  menu_item.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn link_test() {
  let l = link.new("https://example.com")
  let m =
    menu_item.new()
    |> menu_item.link(Some(l))

  let expected =
    element(
      "m3e-menu-item",
      [
        attribute("href", "https://example.com"),
        attribute("target", "_self"),
      ],
      [],
    )

  menu_item.render(m, [], [])
  |> should.equal(expected)
}

pub fn children_test() {
  let m = menu_item.new()
  let child = element("span", [], [])

  let expected = element("m3e-menu-item", [], [child])

  menu_item.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = menu_item.new()
  let attr = attribute("class", "custom")

  let expected = element("m3e-menu-item", [attr], [])

  menu_item.render(m, [attr], [])
  |> should.equal(expected)
}
