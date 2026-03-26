import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/step_panel.{new, render}

pub fn step_panel_new_test() {
  new("step-1")
  |> render
  |> should.equal(
    element.element("m3e-step-panel", [attribute.attribute("id", "step-1")], []),
  )
}

pub fn step_panel_id_test() {
  new("original")
  |> step_panel.id("new-id")
  |> render
  |> should.equal(
    element.element("m3e-step-panel", [attribute.attribute("id", "new-id")], []),
  )
}
