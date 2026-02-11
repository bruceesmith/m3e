import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/menu_item_checkbox

pub fn basic_test() {
  let m = menu_item_checkbox.new()

  let expected = element("m3e-menu-item-checkbox", [], [])

  menu_item_checkbox.render(m, [], [])
  |> should.equal(expected)
}

pub fn checked_test() {
  let m =
    menu_item_checkbox.new()
    |> menu_item_checkbox.checked(True)

  let expected =
    element("m3e-menu-item-checkbox", [attribute("checked", "")], [])

  menu_item_checkbox.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item_checkbox.checked(False)

  let expected2 = element("m3e-menu-item-checkbox", [], [])

  menu_item_checkbox.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn disabled_test() {
  let m =
    menu_item_checkbox.new()
    |> menu_item_checkbox.disabled(True)

  let expected =
    element("m3e-menu-item-checkbox", [attribute("disabled", "")], [])

  menu_item_checkbox.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item_checkbox.disabled(False)

  let expected2 = element("m3e-menu-item-checkbox", [], [])

  menu_item_checkbox.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let m = menu_item_checkbox.new()
  let child = element("span", [], [])

  let expected = element("m3e-menu-item-checkbox", [], [child])

  menu_item_checkbox.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = menu_item_checkbox.new()
  let attr = attribute("class", "custom")

  let expected = element("m3e-menu-item-checkbox", [attr], [])

  menu_item_checkbox.render(m, [attr], [])
  |> should.equal(expected)
}
