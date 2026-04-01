import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/bottom_sheet_trigger

pub fn new_test() {
  let trigger = bottom_sheet_trigger.new()
  let expected =
    element.element(
      "m3e-bottom-sheet-trigger",
      [attribute.attribute("for", "")],
      [element.text("")],
    )

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}

pub fn detent_test() {
  let trigger =
    bottom_sheet_trigger.new()
    |> bottom_sheet_trigger.detent(Some(1))
  let expected =
    element.element(
      "m3e-bottom-sheet-trigger",
      [attribute.attribute("detent", "1"), attribute.attribute("for", "")],
      [element.text("")],
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
    element.element(
      "m3e-bottom-sheet-trigger",
      [attribute.attribute("for", "my-sheet")],
      [
        element.text(""),
      ],
    )

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}

pub fn label_test() {
  let trigger =
    bottom_sheet_trigger.new()
    |> bottom_sheet_trigger.label("My Label")
  let expected =
    element.element(
      "m3e-bottom-sheet-trigger",
      [attribute.attribute("for", "")],
      [
        element.text("My Label"),
      ],
    )

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}

pub fn secondary_test() {
  let trigger =
    bottom_sheet_trigger.new()
    |> bottom_sheet_trigger.secondary(bottom_sheet_trigger.Secondary)
  let expected =
    element.element(
      "m3e-bottom-sheet-trigger",
      [attribute.attribute("for", ""), attribute.attribute("secondary", "")],
      [element.text("")],
    )

  trigger
  |> bottom_sheet_trigger.render
  |> should.equal(expected)
}
