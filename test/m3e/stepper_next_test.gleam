import gleeunit/should
import lustre/element
import m3e/stepper_next.{new, render}

pub fn stepper_next_new_test() {
  new("Next Step")
  |> render
  |> should.equal(
    element.element("m3e-stepper-next", [], [element.text("Next Step")]),
  )
}

pub fn stepper_next_label_test() {
  new("Original")
  |> stepper_next.label("New Label")
  |> render
  |> should.equal(
    element.element("m3e-stepper-next", [], [element.text("New Label")]),
  )
}
