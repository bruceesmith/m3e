import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/option as opt
import m3e/types.{Disabled, Enabled}

pub fn render_test() {
  let o =
    opt.new()
    |> opt.disabled(Disabled)
    |> opt.selected(opt.Selected)
    |> opt.value(Some("test-value"))

  opt.render(o, [], [])
  |> should.equal(
    element.element(
      "m3e-option",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("selected", ""),
        attribute.attribute("value", "test-value"),
      ],
      [],
    ),
  )
}

pub fn render_defaults_test() {
  let o = opt.new()

  opt.render(o, [], [])
  |> should.equal(element.element("m3e-option", [], []))
}

pub fn config_test() {
  let c =
    opt.Config(
      interaction: Disabled,
      selection: opt.Selected,
      value: Some("test-value"),
    )

  let o = opt.from_config(c)

  opt.render(o, [], [])
  |> should.equal(
    element.element(
      "m3e-option",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("selected", ""),
        attribute.attribute("value", "test-value"),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = opt.default_config()

  c.interaction |> should.equal(Enabled)
  c.selection |> should.equal(opt.Unselected)
  c.value |> should.equal(None)
}

pub fn from_config_test() {
  let c = opt.default_config()
  let o = opt.from_config(c)

  opt.render(o, [], [])
  |> should.equal(opt.render(opt.new(), [], []))
}

pub fn render_config_test() {
  let c = opt.default_config()
  let expected = opt.render(opt.from_config(c), [], [])

  opt.render_config(c, [], [])
  |> should.equal(expected)
}

pub fn setters_test() {
  let o =
    opt.new()
    |> opt.disabled(Disabled)
    |> opt.selected(opt.Selected)
    |> opt.value(Some("test-value"))

  opt.render(o, [], [])
  |> should.equal(
    element.element(
      "m3e-option",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("selected", ""),
        attribute.attribute("value", "test-value"),
      ],
      [],
    ),
  )
}
