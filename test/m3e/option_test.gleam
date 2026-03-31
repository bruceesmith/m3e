import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/option as opt
import m3e/state.{Disabled, Enabled, Selected, Unselected}

pub fn render_test() {
  let o =
    opt.new()
    |> opt.disabled(Disabled)
    |> opt.selected(Selected)
    |> opt.value(Some("test-value"))

  opt.render(o, [], [])
  |> should.equal(
    element.element(
      "m3e-option",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("highlight-mode", "contains"),
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
  |> should.equal(
    element.element(
      "m3e-option",
      [attribute.attribute("highlight-mode", "contains")],
      [],
    ),
  )
}

pub fn config_test() {
  let c =
    opt.Config(
      disabled: Disabled,
      highlighting: opt.HighlightEnabled,
      highlight_mode: opt.Contains,
      selection: Selected,
      term: "test-term",
      value: Some("test-value"),
    )

  let o = opt.from_config(c)

  opt.render(o, [], [])
  |> should.equal(
    element.element(
      "m3e-option",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("highlight-mode", "contains"),
        attribute.attribute("term", "test-term"),
        attribute.attribute("selected", ""),
        attribute.attribute("value", "test-value"),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = opt.default_config()

  c.disabled |> should.equal(Enabled)
  c.highlighting |> should.equal(opt.HighlightEnabled)
  c.highlight_mode |> should.equal(opt.Contains)
  c.term |> should.equal("")
  c.selection |> should.equal(Unselected)
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
    |> opt.selected(Selected)
    |> opt.value(Some("test-value"))

  opt.render(o, [], [])
  |> should.equal(
    element.element(
      "m3e-option",
      [
        attribute.disabled(True),
        attribute.attribute("highlight-mode", "contains"),
        attribute.attribute("selected", ""),
        attribute.attribute("value", "test-value"),
      ],
      [],
    ),
  )
}
