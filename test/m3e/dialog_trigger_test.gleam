import gleeunit
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/dialog_trigger

pub fn main() {
  gleeunit.main()
}

pub fn render_test() {
  dialog_trigger.dialog_trigger("my-dialog-id")
  |> dialog_trigger.element
  |> should.equal(
    element.element(
      "m3e-dialog-trigger",
      [attribute.attribute("for", "my-dialog-id")],
      [],
    ),
  )
}
