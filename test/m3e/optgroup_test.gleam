import gleeunit/should
import lustre/element
import m3e/optgroup

pub fn render_test() {
  let group = optgroup.new()

  // Note: optgroup currently renders as m3e-option-panel in the source
  optgroup.render(group, [], [element.text("content")])
  |> should.equal(
    element.element("m3e-option-panel", [], [element.text("content")]),
  )
}
