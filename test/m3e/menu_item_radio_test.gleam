import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/menu_item_radio
import m3e/state.{Checked, Unchecked}

pub fn basic_test() {
  let m = menu_item_radio.new()

  let expected = element.element("m3e-menu-item-radio", [], [])

  menu_item_radio.render(m, [], [])
  |> should.equal(expected)
}

pub fn checked_test() {
  let m =
    menu_item_radio.new()
    |> menu_item_radio.checked(Checked)

  let expected = element.element("m3e-menu-item-radio", [attribute.attribute("checked", "")], [])

  menu_item_radio.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item_radio.checked(Unchecked)

  let expected2 = element.element("m3e-menu-item-radio", [], [])

  menu_item_radio.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn disabled_test() {
  let m =
    menu_item_radio.new()
    |> menu_item_radio.disabled(True)

  let expected = element.element("m3e-menu-item-radio", [attribute.attribute("disabled", "")], [])

  menu_item_radio.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item_radio.disabled(False)

  let expected2 = element.element("m3e-menu-item-radio", [], [])

  menu_item_radio.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let m = menu_item_radio.new()
  let child = element.element("span", [], [])

  let expected = element.element("m3e-menu-item-radio", [], [child])

  menu_item_radio.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = menu_item_radio.new()
  let attr = attribute.attribute("class", "custom")

  let expected = element.element("m3e-menu-item-radio", [attr], [])

  menu_item_radio.render(m, [attr], [])
  |> should.equal(expected)
}
