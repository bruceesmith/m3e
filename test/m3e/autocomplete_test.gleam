import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/autocomplete
import m3e/config.{HideSelectionIndicator, ShowSelectionIndicator}
import m3e/option as m3e_opt
import m3e/types.{Required}

pub fn new_test() {
  autocomplete.new("test-id")
  |> autocomplete.auto_activate(autocomplete.AutoActivate)
  |> autocomplete.requirement(Required)
  |> autocomplete.selection_indicator(ShowSelectionIndicator)
  |> autocomplete.render([])
  |> element.to_string
  |> should.equal(
    "<m3e-autocomplete auto-activate for=\"test-id\" required></m3e-autocomplete>",
  )
}

pub fn render_test() {
  let ac =
    autocomplete.new("test-id")
    |> autocomplete.auto_activate(autocomplete.AutoActivate)
    |> autocomplete.requirement(Required)
    |> autocomplete.selection_indicator(HideSelectionIndicator)
  let opt = m3e_opt.new() |> m3e_opt.value(Some("val"))

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
  let ac = autocomplete.new("test-id")

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
  autocomplete.new("id")
  |> autocomplete.auto_activate(autocomplete.AutoActivate)
  |> autocomplete.render([])
  |> element.to_string
  |> should.equal(
    "<m3e-autocomplete auto-activate for=\"id\"></m3e-autocomplete>",
  )
}

pub fn for_test() {
  autocomplete.new("id")
  |> autocomplete.for("new-id")
  |> autocomplete.render([])
  |> element.to_string
  |> should.equal("<m3e-autocomplete for=\"new-id\"></m3e-autocomplete>")
}

pub fn required_test() {
  autocomplete.new("id")
  |> autocomplete.requirement(Required)
  |> autocomplete.render([])
  |> element.to_string
  |> should.equal("<m3e-autocomplete for=\"id\" required></m3e-autocomplete>")
}

pub fn hide_selection_indicator_test() {
  autocomplete.new("id")
  |> autocomplete.selection_indicator(HideSelectionIndicator)
  |> autocomplete.render([])
  |> element.to_string
  |> should.equal(
    "<m3e-autocomplete for=\"id\" hide-selection-indicator></m3e-autocomplete>",
  )
}
