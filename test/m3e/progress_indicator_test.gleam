import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import m3e/progress_indicator.{
  Buffer, Determinate, Query, buffer_value, circular, content, diameter, element,
  indeterminate, linear, max, mode, stroke_width, value,
}

pub fn circular_test() {
  let pi = circular(None, 50, True, 100, 5, 25)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)
}

pub fn circular_default_values_test() {
  let pi = circular(None, 0, False, 0, 0, 0)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("max", "0"),
        attribute("stroke-width", "0"),
        attribute("value", "0"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)
}

pub fn linear_test() {
  let pi = linear(10, 100, Buffer, 25)
  let expected =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)
}

pub fn linear_default_values_test() {
  let pi = linear(0, 0, Determinate, 0)
  let expected =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "0"),
        attribute("max", "0"),
        attribute("mode", "determinate"),
        attribute("value", "0"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)
}

pub fn element_circular_test() {
  let pi = circular(Some("50%"), 50, True, 100, 5, 50)
  let expected_element =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
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
        attribute("max", "100"),
        attribute("mode", "determinate"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_element)
}

pub fn buffer_value_test() {
  let pi = linear(10, 100, Buffer, 25) |> buffer_value(50)
  let expected =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "50"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)

  // Should be capped by max
  let pi = linear(10, 100, Buffer, 25) |> buffer_value(150)
  let expected_capped =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "100"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_capped)

  // Should be capped at 0
  let pi = linear(10, 100, Buffer, 25) |> buffer_value(-50)
  let expected_zero =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "0"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_zero)

  // Should not apply to Circular
  let pi = circular(None, 50, True, 100, 5, 25) |> buffer_value(50)
  let expected_circular =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_circular)
}

pub fn content_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> content(Some("New Content"))
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [element.text("New Content")],
    )
  element(pi) |> should.equal(expected)

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> content(Some("New Content"))
  let expected_linear =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_linear)
}

pub fn diameter_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> diameter(60)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "60"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)

  // Should be capped at 0
  let pi = circular(None, 50, True, 100, 5, 25) |> diameter(-10)
  let expected_zero =
    element.element(
      "m3e-circular-progress-indicator",
      [
        // diameter 0 -> none
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_zero)

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> diameter(60)
  let expected_linear =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_linear)
}

pub fn indeterminate_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> indeterminate(False)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> indeterminate(True)
  let expected_linear =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_linear)
}

pub fn max_test() {
  let pi = circular(None, 50, False, 100, 5, 25) |> max(200)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("max", "200"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)

  // Should be capped at 0
  let pi = circular(None, 50, False, 100, 5, 25) |> max(-10)
  let expected_zero =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("max", "0"),
        attribute("stroke-width", "5"),
        // value is clamped to max (0)
        attribute("value", "0"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_zero)

  // Should not apply to Circular if indeterminate
  let pi = circular(None, 50, True, 100, 5, 25) |> max(200)
  let expected_indet =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_indet)

  let pi = linear(10, 100, Determinate, 25) |> max(200)
  let expected_linear =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "200"),
        attribute("mode", "determinate"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_linear)

  // Should not apply to Linear if mode is not Determinate
  let pi = linear(10, 100, Buffer, 25) |> max(200)
  let expected_buffer =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_buffer)
}

pub fn mode_test() {
  let pi = linear(10, 100, Determinate, 25) |> mode(Query)
  let expected =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "query"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)

  // Should not apply to Circular
  let pi = circular(None, 50, True, 100, 5, 25) |> mode(Query)
  let expected_circular =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_circular)
}

pub fn stroke_width_test() {
  let pi = circular(None, 50, True, 100, 5, 25) |> stroke_width(10)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "10"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)

  // Should be capped at 0
  let pi = circular(None, 50, True, 100, 5, 25) |> stroke_width(-5)
  let expected_zero =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "0"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_zero)

  // Should not apply to Linear
  let pi = linear(10, 100, Buffer, 25) |> stroke_width(10)
  let expected_linear =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "buffer"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_linear)
}

pub fn value_test() {
  let pi = circular(None, 50, False, 100, 5, 25) |> value(75)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "75"),
      ],
      [],
    )
  element(pi) |> should.equal(expected)

  // Should be capped by max
  let pi = circular(None, 50, False, 100, 5, 25) |> value(150)
  let expected_capped =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "100"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_capped)

  // Should be capped at 0
  let pi = circular(None, 50, False, 100, 5, 25) |> value(-50)
  let expected_zero =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "0"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_zero)

  // Should not apply to Circular if indeterminate
  let pi = circular(None, 50, True, 100, 5, 25) |> value(75)
  let expected_indet =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute("diameter", "50"),
        attribute("indeterminate", ""),
        attribute("max", "100"),
        attribute("stroke-width", "5"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_indet)

  let pi = linear(10, 100, Determinate, 25) |> value(75)
  let expected_linear =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "determinate"),
        attribute("value", "75"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_linear)

  // Should not apply to Linear if mode is not Buffer or Determinate
  let pi = linear(10, 100, Query, 25) |> value(75)
  let expected_query =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute("buffer-value", "10"),
        attribute("max", "100"),
        attribute("mode", "query"),
        attribute("value", "25"),
      ],
      [],
    )
  element(pi) |> should.equal(expected_query)
}
