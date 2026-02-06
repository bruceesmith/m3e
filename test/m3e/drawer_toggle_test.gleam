import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/drawer_toggle.{new, render}

pub fn drawer_toggle_creation_test() {
  let dt = new("my-drawer")
  let expected = element("m3e-drawer-toggle", [attribute.for("my-drawer")], [])
  dt
  |> render([], [])
  |> should.equal(expected)
}

pub fn drawer_toggle_element_test() {
  let dt = new("drawer-id")
  let expected =
    element("m3e-drawer-toggle", [attribute.for("drawer-id")], [
      text("Toggle"),
    ])

  dt
  |> render([], [text("Toggle")])
  |> should.equal(expected)
}

pub fn drawer_toggle_element_with_attributes_test() {
  let dt = new("drawer-id")
  let expected =
    element(
      "m3e-drawer-toggle",
      [attribute.for("drawer-id"), attribute.class("extra-class")],
      [],
    )

  dt
  |> render([attribute.class("extra-class")], [])
  |> should.equal(expected)
}
