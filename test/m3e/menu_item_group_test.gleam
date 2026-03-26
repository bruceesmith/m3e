import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/menu_item_group

pub fn basic_test() {
  let g = menu_item_group.new()

  let expected = element.element("m3e-menu-item-group", [], [])

  menu_item_group.render(g, [], [])
  |> should.equal(expected)
}

pub fn children_test() {
  let g = menu_item_group.new()
  let child = element.element("span", [], [])

  let expected = element.element("m3e-menu-item-group", [], [child])

  menu_item_group.render(g, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let g = menu_item_group.new()
  let attr = attribute.attribute("class", "custom")

  let expected = element.element("m3e-menu-item-group", [attr], [])

  menu_item_group.render(g, [attr], [])
  |> should.equal(expected)
}
