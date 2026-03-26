import gleeunit/should
import lustre/element

import m3e/stepper_reset

pub fn stepper_reset_new_test() {
  stepper_reset.new("Reset Stepper")
  |> stepper_reset.render
  |> should.equal(
    element.element("m3e-stepper-reset", [], [element.text("Reset Stepper")]),
  )
}

pub fn stepper_reset_label_test() {
  stepper_reset.new("Original")
  |> stepper_reset.label("New Label")
  |> stepper_reset.render
  |> should.equal(
    element.element("m3e-stepper-reset", [], [element.text("New Label")]),
  )
}
