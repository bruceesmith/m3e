import gleeunit/should
import lustre/element
import m3e/stepper_reset.{new, render}

pub fn stepper_reset_new_test() {
  new("Reset Stepper")
  |> render
  |> should.equal(
    element.element("m3e-stepper-reset", [], [element.text("Reset Stepper")]),
  )
}

pub fn stepper_reset_label_test() {
  new("Original")
  |> stepper_reset.label("New Label")
  |> render
  |> should.equal(
    element.element("m3e-stepper-reset", [], [element.text("New Label")]),
  )
}
