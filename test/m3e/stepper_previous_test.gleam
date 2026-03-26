import gleeunit/should
import lustre/element

import m3e/stepper_previous

pub fn stepper_previous_new_test() {
  stepper_previous.new("Back")
  |> stepper_previous.render
  |> should.equal(
    element.element("m3e-stepper-previous", [], [element.text("Back")]),
  )
}

pub fn stepper_previous_label_test() {
  stepper_previous.new("Original")
  |> stepper_previous.label("New Label")
  |> stepper_previous.render
  |> should.equal(
    element.element("m3e-stepper-previous", [], [element.text("New Label")]),
  )
}
