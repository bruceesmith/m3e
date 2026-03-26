import gleeunit/should
import lustre/element
import m3e/bottom_sheet_action

pub fn new_test() {
  let action = bottom_sheet_action.new()
  let expected =
    element.element("m3e-bottom-sheet-action", [], [element.text("")])

  action
  |> bottom_sheet_action.render
  |> should.equal(expected)
}

pub fn label_test() {
  let action =
    bottom_sheet_action.new()
    |> bottom_sheet_action.label("Test Label")
  let expected =
    element.element("m3e-bottom-sheet-action", [], [element.text("Test Label")])

  action
  |> bottom_sheet_action.render
  |> should.equal(expected)
}
