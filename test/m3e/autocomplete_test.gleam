import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/autocomplete
import m3e/option as m3e_opt

pub fn new_test() {
  autocomplete.new(True, "test-id", True, False)
  |> should.equal(autocomplete.Autocomplete(
    auto_activate: True,
    for: "test-id",
    required: True,
    hide_selection_indicator: False,
  ))
}

pub fn render_test() {
  let ac = autocomplete.new(True, "test-id", True, True)
  let opt = m3e_opt.new(False, False, Some("val"))

  autocomplete.render(ac, [opt])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("auto-activate", ""),
        attribute.attribute("for", "test-id"),
        attribute.attribute("required", ""),
        attribute.attribute("hide-selection-indicator", ""),
      ],
      [
        element.element("m3e-option", [attribute.attribute("value", "val")], []),
      ],
    ),
  )
}

pub fn render_defaults_test() {
  let ac = autocomplete.new(False, "test-id", False, False)

  autocomplete.render(ac, [])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [attribute.attribute("for", "test-id")],
      [],
    ),
  )
}

pub fn auto_activate_test() {
  autocomplete.new(False, "id", False, False)
  |> autocomplete.auto_activate(True)
  |> should.equal(autocomplete.Autocomplete(
    auto_activate: True,
    for: "id",
    required: False,
    hide_selection_indicator: False,
  ))
}

pub fn for_test() {
  autocomplete.new(False, "id", False, False)
  |> autocomplete.for("new-id")
  |> should.equal(autocomplete.Autocomplete(
    auto_activate: False,
    for: "new-id",
    required: False,
    hide_selection_indicator: False,
  ))
}

pub fn required_test() {
  autocomplete.new(False, "id", False, False)
  |> autocomplete.required(True)
  |> should.equal(autocomplete.Autocomplete(
    auto_activate: False,
    for: "id",
    required: True,
    hide_selection_indicator: False,
  ))
}

pub fn hide_selection_indicator_test() {
  autocomplete.new(False, "id", False, False)
  |> autocomplete.hide_selection_indicator(True)
  |> should.equal(autocomplete.Autocomplete(
    auto_activate: False,
    for: "id",
    required: False,
    hide_selection_indicator: True,
  ))
}
