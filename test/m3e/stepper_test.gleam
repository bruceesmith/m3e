import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/stepper.{Auto, Below, Check, Horizontal, LabelBelow, Vertical}

pub fn stepper_new_test() {
  stepper.new()
  |> stepper.render([], [])
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
  stepper.new()
  |> stepper.header_position(Below)
  |> stepper.label_position(LabelBelow)
  |> stepper.linear(Check)
  |> stepper.orientation(Vertical)
  |> stepper.render([attribute.attribute("id", "my-stepper")], [
    element.text("Child"),
  ])
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
  stepper.new()
  |> stepper.orientation(Auto)
  |> stepper.render([], [])
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

  stepper.new()
  |> stepper.orientation(Horizontal)
  |> stepper.render([], [])
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
