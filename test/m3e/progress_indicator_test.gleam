import gleam/int
import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/progress_indicator.{
  Buffer, Determinate, Indeterminate, buffer_value, circular, content,
  default_diameter, diameter, indeterminate, linear, max, mode, render,
  stroke_width, value,
}

pub fn circular_test() {
  let pi =
    circular()
    |> diameter(50)
    |> indeterminate(Indeterminate)
    |> max(100)
    |> stroke_width(5)
    |> value(25)
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("diameter", "50"),
        attribute.attribute("indeterminate", ""),
        attribute.attribute("max", "1"),
        attribute.attribute("stroke-width", "5"),
        attribute.attribute("value", "0"),
      ],
      [],
    )
  render(pi, []) |> should.equal(expected)
}

pub fn circular_default_values_test() {
  let pi = circular()
  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("diameter", int.to_string(default_diameter)),
        attribute.attribute("max", "1"),
        attribute.attribute("stroke-width", "10"),
        attribute.attribute("value", "0"),
      ],
      [],
    )
  render(pi, []) |> should.equal(expected)
}

pub fn linear_test() {
  let pi =
    linear()
    |> max(100)
    |> mode(Buffer)
    |> value(25)
    |> buffer_value(10)
  let expected =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute.attribute("buffer-value", "10"),
        attribute.attribute("max", "100"),
        attribute.attribute("mode", "buffer"),
        attribute.attribute("value", "25"),
      ],
      [],
    )
  render(pi, []) |> should.equal(expected)
}

pub fn linear_default_values_test() {
  let pi = linear() |> max(0)
  let expected =
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute.attribute("buffer-value", "0"),
        attribute.attribute("max", "0"),
        attribute.attribute("mode", "determinate"),
        attribute.attribute("value", "0"),
      ],
      [],
    )
  render(pi, []) |> should.equal(expected)
}

pub fn element_circular_test() {
  let pi =
    circular()
    |> content(Some("50%"))
    |> diameter(50)
    |> indeterminate(Indeterminate)
    |> max(100)
    |> stroke_width(5)
    |> value(50)
  let expected_element =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("diameter", "50"),
        attribute.attribute("indeterminate", ""),
        attribute.attribute("max", "1"),
        attribute.attribute("stroke-width", "5"),
        attribute.attribute("value", "0"),
      ],
      [element.text("50%")],
    )
  render(pi, []) |> should.equal(expected_element)
}

pub fn config_test() {
  let c =
    progress_indicator.Config(
      buffer_value: 10,
      content: Some("75%"),
      diameter: 60,
      max: 100,
      mode: Determinate,
      stroke_width: 8,
      value: 75,
      variant: progress_indicator.Circular,
    )

  let pi = progress_indicator.from_config(c)

  render(pi, [])
  |> should.equal(
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("diameter", "60"),
        attribute.attribute("max", "100"),
        attribute.attribute("stroke-width", "8"),
        attribute.attribute("value", "75"),
      ],
      [element.text("75%")],
    ),
  )
}

pub fn default_config_test() {
  let c = progress_indicator.default_config()

  c.buffer_value |> should.equal(0)
  c.content |> should.equal(None)
  c.diameter |> should.equal(default_diameter)
  c.max |> should.equal(1)
  c.mode |> should.equal(Determinate)
  c.stroke_width |> should.equal(10)
  c.value |> should.equal(0)
  c.variant |> should.equal(progress_indicator.Linear)
}

pub fn render_config_test() {
  let c = progress_indicator.default_config()
  let expected = render(progress_indicator.from_config(c), [])

  progress_indicator.render_config(c, [])
  |> should.equal(expected)
}

pub fn indeterminate_test() {
  let pi =
    circular()
    |> diameter(50)
    |> indeterminate(Indeterminate)

  let expected =
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("diameter", "50"),
        attribute.attribute("indeterminate", ""),
        attribute.attribute("max", "1"),
        attribute.attribute("stroke-width", "10"),
        attribute.attribute("value", "0"),
      ],
      [],
    )
  render(pi, []) |> should.equal(expected)
}
