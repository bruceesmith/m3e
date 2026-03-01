import gleeunit/should
import lustre/element.{element, text}
import m3e/stepper_next.{new, render}

pub fn stepper_next_new_test() {
  new("Next Step")
  |> render
  |> should.equal(element("m3e-stepper-next", [], [text("Next Step")]))
}

pub fn stepper_next_label_test() {
  new("Original")
  |> stepper_next.label("New Label")
  |> render
  |> should.equal(element("m3e-stepper-next", [], [text("New Label")]))
}
