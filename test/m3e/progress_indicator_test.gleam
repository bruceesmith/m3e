import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute, none}
import lustre/element
import m3e/progress_indicator.{
  Buffer, Circular, Determinate, Linear, Query, buffer_value, circular, content,
  default_diameter, default_stroke_width, diameter, element, indeterminate,
  linear, max, mode, stroke_width, value,
}

pub fn circular_test() {
  let pi = circular(None, 50, True, 100, 5, 25)
  pi.buffer_value |> should.equal(0)
  pi.content |> should.equal(None)
  pi.diameter |> should.equal(50)
  pi.indeterminate |> should.be_true()
  pi.max |> should.equal(100)
  pi.mode |> should.equal(Determinate)
  pi.stroke_width |> should.equal(5)
  pi.value |> should.equal(25)
  pi.variant |> should.equal(Circular)
}

pub fn circular_default_values_test() {
  let pi = circular(None, 0, False, 0, 0, 0)
  pi.diameter |> should.equal(0)
  pi.max |> should.equal(0)
  pi.stroke_width |> should.equal(0)
  pi.value |> should.equal(0)
}

pub fn linear_test() {
  let pi = linear(10, 100, Buffer, 25)
  pi.buffer_value |> should.equal(10)
  pi.content |> should.equal(None)
  pi.diameter |> should.equal(default_diameter)
  pi.indeterminate |> should.be_false()
  pi.max |> should.equal(100)
  pi.mode |> should.equal(Buffer)
  pi.stroke_width |> should.equal(default_stroke_width)
  pi.value |> should.equal(25)
  pi.variant |> should.equal(Linear)
}

pub fn linear_default_values_test() {
  let pi = linear(0, 0, Determinate, 0)
  pi.buffer_value |> should.equal(0)
  pi.max |> should.equal(0)
  pi.value |> should.equal(0)
}

pub fn element_circular_test() {
  let pi = circular(Some("50%"), 50, True, 100, 5, 50)
  let expected_element =
    element.element(
      "m3e-circular-progress-indicator",
      [
        none(),
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        none(),
        attribute("stroke-width", "5"),
        attribute("value", "50"),
      ],
      [element.text("50%")],
    )
  element(pi) |> should.equal(expected_element)
}

pub fn element_linear_test() {
  let pi = linear(10, 100, Determinate, 25)
  let expected_element =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        none(),
        none(),
        attribute("max", "100"),
        attribute("mode", "determinate"),
        none(),
        attribute("value", "25"),
      ],
      [element.none()],
    )
  element(pi) |> should.equal(expected_element)
}

pub fn buffer_value_test() {
  let pi = linear(10, 100, Buffer, 25) |> buffer_value(50)
  pi.buffer_value |> should.equal(50)

  // Should be capped by max
  let pi = linear(10, 100, Buffer, 25) |> buffer_value(150)
  pi.buffer_value |> should.equal(100)

  // Should be capped at 0
  let pi = linear(10, 100, Buffer, 25) |> buffer_value(-50)
  pi.buffer_value |> should.equal(0)

  // Should not apply to Circular
  let pi = circular(None, 50, True, 100, 5, 25) |> buffer_value(50)
  pi.buffer_value |> should.equal(0)
}

pub fn content_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> content(Some("New Content"))
  pi.content |> should.equal(Some("New Content"))

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> content(Some("New Content"))
  pi.content |> should.equal(None)
}

pub fn diameter_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> diameter(60)
  pi.diameter |> should.equal(60)

  // Should be capped at 0
  let pi = circular(None, 50, True, 100, 5, 25) |> diameter(-10)
  pi.diameter |> should.equal(0)

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> diameter(60)
  pi.diameter |> should.equal(default_diameter)
}

pub fn indeterminate_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> indeterminate(False)
  pi.indeterminate |> should.be_false()

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> indeterminate(True)
  pi.indeterminate |> should.be_false()
}

pub fn max_test() {
  let pi = circular(None, 50, False, 100, 5, 25) |> max(200)
  pi.max |> should.equal(200)

  // Should be capped at 0
  let pi = circular(None, 50, False, 100, 5, 25) |> max(-10)
  pi.max |> should.equal(0)

  // Should not apply to Circular if indeterminate
  let pi = circular(None, 50, True, 100, 5, 25) |> max(200)
  pi.max |> should.equal(100)

  let pi = linear(10, 100, Determinate, 25) |> max(200)
  pi.max |> should.equal(200)

  // Should not apply to Linear if mode is not Determinate
  let pi = linear(10, 100, Buffer, 25) |> max(200)
  pi.max |> should.equal(100)
}

pub fn mode_test() {
  let pi = linear(10, 100, Determinate, 25) |> mode(Query)
  pi.mode |> should.equal(Query)

  // Should not apply to Circular
  let pi = circular(None, 50, True, 100, 5, 25) |> mode(Query)
  pi.mode |> should.equal(Determinate)
}

pub fn stroke_width_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> stroke_width(10)
  pi.stroke_width |> should.equal(10)

  // Should be capped at 0
  let pi = circular(None, 50, True, 100, 5, 25) |> stroke_width(-5)
  pi.stroke_width |> should.equal(0)

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> stroke_width(10)
  pi.stroke_width |> should.equal(default_stroke_width)
}

pub fn value_test() {
  let pi = circular(None, 50, False, 100, 5, 25) |> value(75)
  pi.value |> should.equal(75)

  // Should be capped by max
  let pi = circular(None, 50, False, 100, 5, 25) |> value(150)
  pi.value |> should.equal(100)

  // Should be capped at 0
  let pi = circular(None, 50, False, 100, 5, 25) |> value(-50)
  pi.value |> should.equal(0)

  // Should not apply to Circular if indeterminate
  let pi = circular(None, 50, True, 100, 5, 25) |> value(75)
  pi.value |> should.equal(25)

  let pi = linear(10, 100, Determinate, 25) |> value(75)
  pi.value |> should.equal(75)

  // Should not apply to Linear if mode is not Buffer or Determinate
  let pi = linear(10, 100, Query, 25) |> value(75)
  pi.value |> should.equal(25)
}
