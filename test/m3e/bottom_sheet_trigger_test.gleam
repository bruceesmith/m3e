import gleam/option.{Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element, text}
import m3e/bottom_sheet_trigger

pub fn new_test() {
  let trigger = bottom_sheet_trigger.new()
  let expected =
    element("m3e-bottom-sheet-trigger", [attribute("for", "")], [text("")])

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}

pub fn detent_test() {
  let trigger =
    bottom_sheet_trigger.new()
    |> bottom_sheet_trigger.detent(Some(1))
  let expected =
    element(
      "m3e-bottom-sheet-trigger",
      [attribute("detent", "1"), attribute("for", "")],
      [text("")],
    )

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}

pub fn for_test() {
  let trigger =
    bottom_sheet_trigger.new()
    |> bottom_sheet_trigger.for("my-sheet")
  let expected =
    element("m3e-bottom-sheet-trigger", [attribute("for", "my-sheet")], [
      text(""),
    ])

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}

pub fn label_test() {
  let trigger =
    bottom_sheet_trigger.new()
    |> bottom_sheet_trigger.label("My Label")
  let expected =
    element("m3e-bottom-sheet-trigger", [attribute("for", "")], [
      text("My Label"),
    ])

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}

pub fn secondary_test() {
  let trigger =
    bottom_sheet_trigger.new()
    |> bottom_sheet_trigger.secondary(True)
  let expected =
    element(
      "m3e-bottom-sheet-trigger",
      [attribute("for", ""), attribute("secondary", "")],
      [text("")],
    )

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}
