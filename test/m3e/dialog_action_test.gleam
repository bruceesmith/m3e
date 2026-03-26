import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/dialog_action

pub fn basic_render_test() {
  dialog_action.new("Confirm")
  |> dialog_action.render([], [])
  |> should.equal(
    element.element(
      "m3e-dialog-action",
      [attribute.attribute("return-value", "Confirm")],
      [],
    ),
  )
}
