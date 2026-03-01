import gleeunit/should
import lustre/element.{element, text}
import m3e/stepper_previous.{new, render}

pub fn stepper_previous_new_test() {
  new("Back")
  |> render
  |> should.equal(element("m3e-stepper-previous", [], [text("Back")]))
}

pub fn stepper_previous_label_test() {
  new("Original")
  |> stepper_previous.label("New Label")
  |> render
  |> should.equal(element("m3e-stepper-previous", [], [text("New Label")]))
}
