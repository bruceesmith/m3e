import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element, text}
import m3e/stepper.{
  Auto, Below, Horizontal, LabelBelow, Vertical, header_position,
  label_position, linear, new, orientation, render,
}

pub fn stepper_new_test() {
  new()
  |> render([], [])
  |> should.equal(
    element(
      "m3e-stepper",
      [
        attribute("header-position", "above"),
        attribute("label-position", "end"),
        attribute("orientation", "horizontal"),
      ],
      [],
    ),
  )
}

pub fn stepper_full_test() {
  new()
  |> header_position(Below)
  |> label_position(LabelBelow)
  |> linear(True)
  |> orientation(Vertical)
  |> render([attribute("id", "my-stepper")], [text("Child")])
  |> should.equal(
    element(
      "m3e-stepper",
      [
        attribute("header-position", "below"),
        attribute("label-position", "below"),
        attribute("linear", ""),
        attribute("orientation", "vertical"),
        attribute("id", "my-stepper"),
      ],
      [text("Child")],
    ),
  )
}

pub fn stepper_orientation_test() {
  new()
  |> orientation(Auto)
  |> render([], [])
  |> should.equal(
    element(
      "m3e-stepper",
      [
        attribute("header-position", "above"),
        attribute("label-position", "end"),
        attribute("orientation", "auto"),
      ],
      [],
    ),
  )

  new()
  |> orientation(Horizontal)
  |> render([], [])
  |> should.equal(
    element(
      "m3e-stepper",
      [
        attribute("header-position", "above"),
        attribute("label-position", "end"),
        attribute("orientation", "horizontal"),
      ],
      [],
    ),
  )
}
