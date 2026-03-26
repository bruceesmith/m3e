import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/stepper.{
  Auto, Below, Check, Horizontal, LabelBelow, Vertical, header_position,
  label_position, linear, new, orientation, render,
}

pub fn stepper_new_test() {
  new()
  |> render([], [])
  |> should.equal(
    element.element(
      "m3e-stepper",
      [
        attribute.attribute("header-position", "above"),
        attribute.attribute("label-position", "end"),
        attribute.attribute("orientation", "horizontal"),
      ],
      [],
    ),
  )
}

pub fn stepper_full_test() {
  new()
  |> header_position(Below)
  |> label_position(LabelBelow)
  |> linear(Check)
  |> orientation(Vertical)
  |> render([attribute.attribute("id", "my-stepper")], [element.text("Child")])
  |> should.equal(
    element.element(
      "m3e-stepper",
      [
        attribute.attribute("header-position", "below"),
        attribute.attribute("label-position", "below"),
        attribute.attribute("linear", ""),
        attribute.attribute("orientation", "vertical"),
        attribute.attribute("id", "my-stepper"),
      ],
      [element.text("Child")],
    ),
  )
}

pub fn stepper_orientation_test() {
  new()
  |> orientation(Auto)
  |> render([], [])
  |> should.equal(
    element.element(
      "m3e-stepper",
      [
        attribute.attribute("header-position", "above"),
        attribute.attribute("label-position", "end"),
        attribute.attribute("orientation", "auto"),
      ],
      [],
    ),
  )

  new()
  |> orientation(Horizontal)
  |> render([], [])
  |> should.equal(
    element.element(
      "m3e-stepper",
      [
        attribute.attribute("header-position", "above"),
        attribute.attribute("label-position", "end"),
        attribute.attribute("orientation", "horizontal"),
      ],
      [],
    ),
  )
}
