import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/menu_item_checkbox

pub fn basic_test() {
  let m = menu_item_checkbox.new()

  let expected = element.element("m3e-menu-item-checkbox", [], [])

  menu_item_checkbox.render(m, [], [])
  |> should.equal(expected)
}

pub fn checked_test() {
  let m =
    menu_item_checkbox.new()
    |> menu_item_checkbox.checked(True)

  let expected =
    element.element(
      "m3e-menu-item-checkbox",
      [attribute.attribute("checked", "")],
      [],
    )

  menu_item_checkbox.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item_checkbox.checked(False)

  let expected2 = element.element("m3e-menu-item-checkbox", [], [])

  menu_item_checkbox.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn disabled_test() {
  let m =
    menu_item_checkbox.new()
    |> menu_item_checkbox.disabled(True)

  let expected =
    element.element(
      "m3e-menu-item-checkbox",
      [attribute.attribute("disabled", "")],
      [],
    )

  menu_item_checkbox.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    m
    |> menu_item_checkbox.disabled(False)

  let expected2 = element.element("m3e-menu-item-checkbox", [], [])

  menu_item_checkbox.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let m = menu_item_checkbox.new()
  let child = element.element("span", [], [])

  let expected = element.element("m3e-menu-item-checkbox", [], [child])

  menu_item_checkbox.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = menu_item_checkbox.new()
  let attr = attribute.attribute("class", "custom")

  let expected = element.element("m3e-menu-item-checkbox", [attr], [])

  menu_item_checkbox.render(m, [attr], [])
  |> should.equal(expected)
}
