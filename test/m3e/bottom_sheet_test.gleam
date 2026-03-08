import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element, text}
import m3e/bottom_sheet

pub fn new_test() {
  let sheet = bottom_sheet.new()
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn detent_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.detent(1)
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "1"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn detents_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.detents([bottom_sheet.Full, bottom_sheet.Half])
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("detents", "full half"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn handle_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.handle(True)
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle", ""),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn handle_label_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.handle_label("Drag me")
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", "Drag me"),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn hideable_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.hideable(True)
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", ""),
        attribute("hideable", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn hide_friction_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.hide_friction(0.8)
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.8"),
        attribute("id", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn id_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.id("my-sheet")
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", "my-sheet"),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn modal_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.modal(True)
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
        attribute("modal", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn open_test() {
  let sheet =
    bottom_sheet.new()
    |> bottom_sheet.open(True)
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
        attribute("open", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn children_test() {
  let sheet = bottom_sheet.new()
  let child = element("div", [], [text("content")])
  let expected =
    element(
      "m3e-bottom-sheet",
      [
        attribute("detent", "0"),
        attribute("handle-label", ""),
        attribute("hide-friction", "0.5"),
        attribute("id", ""),
      ],
      [child],
    )

  sheet
  |> bottom_sheet.render([child])
  |> should.equal(expected)
}
