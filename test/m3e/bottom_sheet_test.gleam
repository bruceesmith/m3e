import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/bottom_sheet

pub fn new_test() {
  let sheet = bottom_sheet.new()
  let expected =
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
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
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "1"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
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
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("detents", "full half"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
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
    |> bottom_sheet.handle(bottom_sheet.ShowHandle)
  let expected =
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle", ""),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
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
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", "Drag me"),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
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
    |> bottom_sheet.hideable(bottom_sheet.Hideable)
  let expected =
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hideable", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
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
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.8"),
        attribute.attribute("id", ""),
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
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", "my-sheet"),
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
    |> bottom_sheet.modal(bottom_sheet.Modal)
  let expected =
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
        attribute.attribute("modal", ""),
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
    |> bottom_sheet.open(bottom_sheet.Open)
  let expected =
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
        attribute.attribute("open", ""),
      ],
      [],
    )

  sheet
  |> bottom_sheet.render([])
  |> should.equal(expected)
}

pub fn children_test() {
  let sheet = bottom_sheet.new()
  let child = element.element("div", [], [element.text("content")])
  let expected =
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle-label", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", ""),
      ],
      [child],
    )

  sheet
  |> bottom_sheet.render([child])
  |> should.equal(expected)
}

pub fn config_test() {
  let config =
    bottom_sheet.Config(
      detent: 0,
      detents: [],
      handle: bottom_sheet.ShowHandle,
      handle_label: "Drag me",
      hideable: bottom_sheet.Hideable,
      hide_friction: 0.5,
      id: "my-sheet",
      modal: bottom_sheet.Modal,
      open: bottom_sheet.Open,
    )
  let expected =
    element.element(
      "m3e-bottom-sheet",
      [
        attribute.attribute("detent", "0"),
        attribute.attribute("handle", ""),
        attribute.attribute("handle-label", "Drag me"),
        attribute.attribute("hideable", ""),
        attribute.attribute("hide-friction", "0.5"),
        attribute.attribute("id", "my-sheet"),
        attribute.attribute("modal", ""),
        attribute.attribute("open", ""),
      ],
      [],
    )

  config
  |> bottom_sheet.render_config([])
  |> should.equal(expected)
}

pub fn slot_test() {
  bottom_sheet.Header
  |> bottom_sheet.slot
  |> should.equal(attribute.attribute("slot", "header"))
}
