import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/dialog_trigger

pub fn render_test() {
  dialog_trigger.new("my-dialog-id")
  |> dialog_trigger.render([], [])
  |> should.equal(
    element.element(
      "m3e-dialog-trigger",
      [attribute.attribute("for", "my-dialog-id")],
      [],
    ),
  )
}
