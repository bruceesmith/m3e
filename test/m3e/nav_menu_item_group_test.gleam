//// NavMenuItemGroup unit tests
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
import m3e/nav_menu_item_group

pub fn nav_menu_item_group_render_test() {
  let mod = nav_menu_item_group.new()

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-nav-menu-item-group", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-nav-menu-item-group", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-nav-menu-item-group", [], [html.br([])]),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    nav_menu_item_group.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn nav_menu_item_group_slot_test() {
  let cases = [
    #(nav_menu_item_group.Label, attribute.attribute("slot", "label")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    nav_menu_item_group.slot(s)
    |> should.equal(expected)
  })
}
