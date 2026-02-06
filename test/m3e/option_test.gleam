import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/option as opt

pub fn new_test() {
  opt.new(True, False, Some("val"))
  |> should.equal(opt.Option(
    disabled: True,
    selected: False,
    value: Some("val"),
  ))
}

pub fn render_test() {
  let opt = opt.new(True, True, Some("test-value"))

  opt.render(opt)
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
  let opt = opt.new(False, False, None)

  opt.render(opt)
  |> should.equal(element.element("m3e-option", [], []))
}

pub fn disabled_test() {
  opt.new(False, False, None)
  |> opt.disabled(True)
  |> should.equal(opt.Option(disabled: True, selected: False, value: None))
}

pub fn selected_test() {
  opt.new(False, False, None)
  |> opt.selected(True)
  |> should.equal(opt.Option(disabled: False, selected: True, value: None))
}

pub fn value_test() {
  opt.new(False, False, None)
  |> opt.value(Some("new-val"))
  |> should.equal(opt.Option(
    disabled: False,
    selected: False,
    value: Some("new-val"),
  ))
}
