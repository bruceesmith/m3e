import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/linear_progress_indicator
import m3e/progress_indicator

pub fn default_config_test() {
  let config = linear_progress_indicator.default_config()

  config.buffer_value |> should.equal(0.0)
  config.max |> should.equal(1)
  config.mode |> should.equal(linear_progress_indicator.default_mode)
  config.value |> should.equal(0.0)
  config.variant |> should.equal(progress_indicator.default_variant)
}

pub fn render_default_test() {
  linear_progress_indicator.render(linear_progress_indicator.new(), [])
  |> should.equal(
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute.attribute("buffer-value", "0.0"),
        attribute.attribute("max", "1"),
        attribute.attribute("value", "0.0"),
        attribute.attribute("variant", "flat"),
      ],
      [],
    ),
  )
}

pub fn render_indeterminate_test() {
  linear_progress_indicator.render(
    linear_progress_indicator.mode(
      linear_progress_indicator.new(),
      linear_progress_indicator.Indeterminate,
    ),
    [],
  )
  |> should.equal(
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute.attribute("buffer-value", "0.0"),
        attribute.attribute("max", "1"),
        attribute.attribute("indeterminate", ""),
        attribute.attribute("value", "0.0"),
        attribute.attribute("variant", "flat"),
      ],
      [],
    ),
  )
}

pub fn render_config_test() {
  let config =
    linear_progress_indicator.Config(
      buffer_value: 0.25,
      max: 4,
      mode: linear_progress_indicator.Buffer,
      value: 0.5,
      variant: progress_indicator.Wavy,
    )

  linear_progress_indicator.render_config(config, [])
  |> should.equal(
    element.element(
      "m3e-linear-progress-indicator",
      [
        attribute.attribute("buffer-value", "0.25"),
        attribute.attribute("max", "4"),
        attribute.attribute("value", "0.5"),
        attribute.attribute("variant", "wavy"),
      ],
      [],
    ),
  )
}
