import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/menu_item_group

pub fn basic_test() {
  let g = menu_item_group.new()

  let expected = element("m3e-menu-item-group", [], [])

  menu_item_group.render(g, [], [])
  |> should.equal(expected)
}

pub fn children_test() {
  let g = menu_item_group.new()
  let child = element("span", [], [])

  let expected = element("m3e-menu-item-group", [], [child])

  menu_item_group.render(g, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let g = menu_item_group.new()
  let attr = attribute("class", "custom")

  let expected = element("m3e-menu-item-group", [attr], [])

  menu_item_group.render(g, [attr], [])
  |> should.equal(expected)
}
