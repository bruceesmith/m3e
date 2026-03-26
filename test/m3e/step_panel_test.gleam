import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/step_panel

pub fn step_panel_new_test() {
  step_panel.new("step-1")
  |> step_panel.render
  |> should.equal(
    element.element("m3e-step-panel", [attribute.attribute("id", "step-1")], []),
  )
}

pub fn step_panel_id_test() {
  step_panel.new("original")
  |> step_panel.id("new-id")
  |> step_panel.render
  |> should.equal(
    element.element("m3e-step-panel", [attribute.attribute("id", "new-id")], []),
  )
}
