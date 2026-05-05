//// MenuItemCheckbox unit tests
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/menu_item_checkbox.{Config}

pub fn menu_item_checkbox_default_config_test() {
  let cases = [
    Config(
      disabled: menu_item_checkbox.IsNotDisabled,
      checked: menu_item_checkbox.IsNotChecked,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    menu_item_checkbox.default_config()
    |> should.equal(expected)
  })
}

pub fn menu_item_checkbox_from_config_test() {
  let cases = [
    #(
      menu_item_checkbox.Config(
        disabled: menu_item_checkbox.IsDisabled,
        checked: menu_item_checkbox.IsChecked,
      ),
      menu_item_checkbox.new()
        |> menu_item_checkbox.disabled(menu_item_checkbox.IsDisabled)
        |> menu_item_checkbox.checked(menu_item_checkbox.IsChecked),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    menu_item_checkbox.from_config(config)
    |> should.equal(expected)
  })
}

pub fn menu_item_checkbox_new_test() {
  let cases = [
    menu_item_checkbox.from_config(menu_item_checkbox.Config(
      disabled: menu_item_checkbox.IsNotDisabled,
      checked: menu_item_checkbox.IsNotChecked,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    menu_item_checkbox.new()
    |> should.equal(expected)
  })
}

pub fn menu_item_checkbox_disabled_test() {
  let mod = menu_item_checkbox.new()
  let cases = [
    #(
      menu_item_checkbox.IsDisabled,
      menu_item_checkbox.from_config(
        menu_item_checkbox.Config(
          ..menu_item_checkbox.default_config(),
          disabled: menu_item_checkbox.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    menu_item_checkbox.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn menu_item_checkbox_checked_test() {
  let mod = menu_item_checkbox.new()
  let cases = [
    #(
      menu_item_checkbox.IsChecked,
      menu_item_checkbox.from_config(
        menu_item_checkbox.Config(
          ..menu_item_checkbox.default_config(),
          checked: menu_item_checkbox.IsChecked,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    menu_item_checkbox.checked(mod, field)
    |> should.equal(expected)
  })
}

pub fn menu_item_checkbox_render_test() {
  let mod = menu_item_checkbox.new()

  let mod_disabled =
    menu_item_checkbox.new()
    |> menu_item_checkbox.disabled(menu_item_checkbox.IsDisabled)
  let mod_checked =
    menu_item_checkbox.new()
    |> menu_item_checkbox.checked(menu_item_checkbox.IsChecked)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-menu-item-checkbox", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-menu-item-checkbox", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-menu-item-checkbox", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-menu-item-checkbox",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a checked attribute
    #(
      #(mod_checked, [], []),
      element.element(
        "m3e-menu-item-checkbox",
        [attribute.attribute("checked", "")],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    menu_item_checkbox.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn menu_item_checkbox_slot_test() {
  let cases = [
    #(menu_item_checkbox.Icon, attribute.attribute("slot", "icon")),
    #(
      menu_item_checkbox.TrailingIcon,
      attribute.attribute("slot", "trailing-icon"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    menu_item_checkbox.slot(s)
    |> should.equal(expected)
  })
}
