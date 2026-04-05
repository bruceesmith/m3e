import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/circular_progress_indicator
import m3e/linear_progress_indicator
import m3e/progress_indicator

pub fn variant_to_string_flat_test() {
  progress_indicator.variant_to_string(progress_indicator.Flat)
  |> should.equal("flat")
}

pub fn variant_to_string_wavy_test() {
  progress_indicator.variant_to_string(progress_indicator.Wavy)
  |> should.equal("wavy")
}

pub fn default_variant_test() {
  progress_indicator.default_variant
  |> should.equal(progress_indicator.Flat)
}

pub fn shared_variant_render_regression_test() {
  circular_progress_indicator.render(
    circular_progress_indicator.variant(
      circular_progress_indicator.new(),
      progress_indicator.Wavy,
    ),
    [],
  )
  |> should.equal(
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("max", "1"),
        attribute.attribute("value", "0.0"),
        attribute.attribute("variant", "wavy"),
      ],
      [],
    ),
  )

  linear_progress_indicator.render(
    linear_progress_indicator.variant(
      linear_progress_indicator.new(),
      progress_indicator.Wavy,
    ),
    [],
  )
  |> should.equal(
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute.attribute("buffer-value", "0.0"),
        attribute.attribute("max", "1"),
        attribute.attribute("value", "0.0"),
        attribute.attribute("variant", "wavy"),
      ],
      [],
    ),
  )
}
