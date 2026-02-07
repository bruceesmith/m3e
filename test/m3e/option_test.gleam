import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/option as opt

pub fn render_test() {
  let opt =
    opt.new()
    |> opt.disabled(True)
    |> opt.selected(True)
    |> opt.value(Some("test-value"))

  opt.render(opt, [], [])
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
  let opt = opt.new()

  opt.render(opt, [], [])
  |> should.equal(element.element("m3e-option", [], []))
}
