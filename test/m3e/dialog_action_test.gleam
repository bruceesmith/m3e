import gleeunit
import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import m3e/dialog_action

pub fn main() {
  gleeunit.main()
}

pub fn basic_render_test() {
  dialog_action.dialog_action("Confirm")
  |> dialog_action.render
  |> should.equal(
    element(
      "m3e-dialog-action",
      [attribute.attribute("return-value", "Confirm")],
      [],
    ),
  )
}
