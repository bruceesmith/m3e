import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html.{text}
import m3e/drawer_toggle.{draw_toggle, element}

pub fn drawer_toggle_creation_test() {
  let dt = draw_toggle("my-drawer")
  dt.for |> should.equal("my-drawer")
}

pub fn drawer_toggle_element_test() {
  let dt = draw_toggle("drawer-id")
  let expected =
    element.element(
      "m3e-drawer-toggle",
      [attribute.for("drawer-id")],
      [text("Toggle")],
    )

  dt
  |> element([], [text("Toggle")])
  |> should.equal(expected)
}

pub fn drawer_toggle_element_with_attributes_test() {
  let dt = draw_toggle("drawer-id")
  let expected =
    element.element(
      "m3e-drawer-toggle",
      [attribute.for("drawer-id"), attribute.class("extra-class")],
      [],
    )

  dt
  |> element([attribute.class("extra-class")], [])
  |> should.equal(expected)
}
