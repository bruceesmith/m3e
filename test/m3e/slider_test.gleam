import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/size_many.{ExtraSmall, Large}
import m3e/slider
import m3e/types.{Disabled, Enabled}

pub fn default_test() {
  slider.new()
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
      ],
      [],
    ),
  )
}

pub fn disabled_test() {
  slider.new()
  |> slider.disabled(Disabled)
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
      ],
      [],
    ),
  )
}

pub fn discrete_test() {
  slider.new()
  |> slider.discrete(slider.Discrete)
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("discrete", ""),
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
      ],
      [],
    ),
  )
}

pub fn labelled_test() {
  slider.new()
  |> slider.labelled(slider.ShowLabels)
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("labelled", ""),
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
      ],
      [],
    ),
  )
}

pub fn max_test() {
  slider.new()
  |> slider.max(50.0)
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("max", "50.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
      ],
      [],
    ),
  )
}

pub fn min_test() {
  slider.new()
  |> slider.min(10.0)
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "10.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
      ],
      [],
    ),
  )
}

pub fn size_test() {
  slider.new()
  |> slider.size(Large)
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "large"),
        attribute.attribute("step", "1.0"),
      ],
      [],
    ),
  )
}

pub fn step_test() {
  slider.new()
  |> slider.step(0.5)
  |> slider.render([], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "0.5"),
      ],
      [],
    ),
  )
}

pub fn custom_attributes_test() {
  slider.new()
  |> slider.render([attribute.class("custom")], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
        attribute.class("custom"),
      ],
      [],
    ),
  )
}

pub fn children_test() {
  let child = element.element("div", [], [])
  slider.new()
  |> slider.render([], [child])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("max", "100.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
      ],
      [child],
    ),
  )
}

pub fn combined_test() {
  slider.new()
  |> slider.disabled(Disabled)
  |> slider.max(200.0)
  |> slider.render([attribute.id("slider-1")], [])
  |> should.equal(
    element.element(
      "m3e-slider",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("max", "200.0"),
        attribute.attribute("min", "0.0"),
        attribute.attribute("size", "extra-small"),
        attribute.attribute("step", "1.0"),
        attribute.id("slider-1"),
      ],
      [],
    ),
  )
}

pub fn config_test() {
  slider.default_config()
  |> should.equal(slider.Config(
    discrete: slider.Continuous,
    interaction: Enabled,
    labels: slider.HideLabels,
    max: 100.0,
    min: 0.0,
    size: ExtraSmall,
    step: 1.0,
  ))
}

pub fn from_config_test() {
  slider.default_config()
  |> slider.from_config
  |> slider.render([], [])
  |> should.equal(
    slider.new()
    |> slider.render([], []),
  )
}

pub fn render_config_test() {
  slider.default_config()
  |> slider.render_config([], [])
  |> should.equal(
    slider.new()
    |> slider.render([], []),
  )
}
