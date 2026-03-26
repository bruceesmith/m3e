import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/drawer_toggle

pub fn drawer_toggle_creation_test() {
  let dt = drawer_toggle.new("my-drawer")
  let expected =
    element.element("m3e-drawer-toggle", [attribute.for("my-drawer")], [])
  dt
  |> drawer_toggle.render([], [])
  |> should.equal(expected)
}

pub fn drawer_toggle_element_test() {
  let dt = drawer_toggle.new("drawer-id")
  let expected =
    element.element("m3e-drawer-toggle", [attribute.for("drawer-id")], [
      element.text("Toggle"),
    ])

  dt
  |> drawer_toggle.render([], [element.text("Toggle")])
  |> should.equal(expected)
}

pub fn drawer_toggle_element_with_attributes_test() {
  let dt = drawer_toggle.new("drawer-id")
  let expected =
    element.element(
      "m3e-drawer-toggle",
      [attribute.for("drawer-id"), attribute.class("extra-class")],
      [],
    )

  dt
  |> drawer_toggle.render([attribute.class("extra-class")], [])
  |> should.equal(expected)
}
