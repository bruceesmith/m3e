import gleeunit/should
import lustre/element
import m3e/option_panel

pub fn new_test() {
  option_panel.new()
  |> should.equal(option_panel.OptionPanel)
}

pub fn render_test() {
  let panel = option_panel.new()

  option_panel.render(panel, [element.text("content")])
  |> should.equal(
    element.element("m3e-option-panel", [], [element.text("content")]),
  )
}
