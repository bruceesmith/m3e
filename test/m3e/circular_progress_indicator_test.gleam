import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/circular_progress_indicator
import m3e/progress_indicator

pub fn default_config_test() {
  let config = circular_progress_indicator.default_config()

  config.indeterminate |> should.equal(circular_progress_indicator.default_mode)
  config.max |> should.equal(1)
  config.value |> should.equal(0.0)
  config.variant |> should.equal(progress_indicator.default_variant)
}

pub fn render_default_test() {
  circular_progress_indicator.render(circular_progress_indicator.new(), [])
  |> should.equal(
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("max", "1"),
        attribute.attribute("value", "0.0"),
        attribute.attribute("variant", "flat"),
      ],
      [],
    ),
  )
}

pub fn render_indeterminate_test() {
  circular_progress_indicator.render(
    circular_progress_indicator.indeterminate(
      circular_progress_indicator.new(),
      circular_progress_indicator.Indeterminate,
    ),
    [],
  )
  |> should.equal(
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("indeterminate", ""),
        attribute.attribute("max", "1"),
        attribute.attribute("value", "0.0"),
        attribute.attribute("variant", "flat"),
      ],
      [],
    ),
  )
}

pub fn render_from_config_test() {
  let config =
    circular_progress_indicator.Config(
      indeterminate: circular_progress_indicator.default_mode,
      max: 2,
      value: 0.5,
      variant: progress_indicator.Wavy,
    )

  circular_progress_indicator.render(
    circular_progress_indicator.from_config(config),
    [],
  )
  |> should.equal(
    element.element(
      "m3e-circular-progress-indicator",
      [
        attribute.attribute("max", "2"),
        attribute.attribute("value", "0.5"),
        attribute.attribute("variant", "wavy"),
      ],
      [],
    ),
  )
}
