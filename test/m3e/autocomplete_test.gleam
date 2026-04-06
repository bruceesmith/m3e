import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/autocomplete
import m3e/config.{HideSelectionIndicator, ShowSelectionIndicator}
import m3e/option as m3e_opt
import m3e/state.{Required}

pub fn new_test() {
  autocomplete.new("test-id")
  |> autocomplete.auto_activate(autocomplete.AutoActivate)
  |> autocomplete.required(Required)
  |> autocomplete.hide_selection_indicator(ShowSelectionIndicator)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("auto-activate", ""),
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "test-id"),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("required", ""),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn render_test() {
  let ac =
    autocomplete.new("test-id")
    |> autocomplete.auto_activate(autocomplete.AutoActivate)
    |> autocomplete.required(Required)
    |> autocomplete.hide_selection_indicator(HideSelectionIndicator)
  let opt = m3e_opt.new() |> m3e_opt.value(Some("val"))

  autocomplete.render(ac, [opt])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("auto-activate", ""),
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "test-id"),
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("required", ""),
        attribute.attribute("results-label", ""),
      ],
      [
        element.element(
          "m3e-option",
          [
            attribute.attribute("highlight-mode", "contains"),
            attribute.attribute("value", "val"),
          ],
          [],
        ),
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
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "test-id"),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn auto_activate_test() {
  autocomplete.new("id")
  |> autocomplete.auto_activate(autocomplete.AutoActivate)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("auto-activate", ""),
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "id"),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn for_test() {
  autocomplete.new("id")
  |> autocomplete.for_("new-id")
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "new-id"),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn required_test() {
  autocomplete.new("id")
  |> autocomplete.required(Required)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "id"),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("required", ""),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn hide_hide_selection_indicator_test() {
  autocomplete.new("id")
  |> autocomplete.hide_selection_indicator(HideSelectionIndicator)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "id"),
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn hide_no_data_test() {
  autocomplete.new("id")
  |> autocomplete.hide_no_data(autocomplete.HideEmptyMenu)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "id"),
        attribute.attribute("hide-no-data", ""),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn case_sensitive_test() {
  autocomplete.new("id")
  |> autocomplete.case_sensitive(autocomplete.CaseSensitive)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "id"),
        attribute.attribute("case-sensitive", ""),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn hide_loading_test() {
  autocomplete.new("id")
  |> autocomplete.hide_loading(autocomplete.HideLoadingIndicator)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "id"),
        attribute.attribute("hide-loading", ""),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}

pub fn loading_test() {
  autocomplete.new("id")
  |> autocomplete.loading(autocomplete.IsLoading)
  |> autocomplete.render([])
  |> should.equal(
    element.element(
      "m3e-autocomplete",
      [
        attribute.attribute("filter", "contains"),
        attribute.attribute("for", "id"),
        attribute.attribute("loading", ""),
        attribute.attribute("loading-label", "Loading..."),
        attribute.attribute("no-data-label", "No options"),
        attribute.attribute("results-label", ""),
      ],
      [],
    ),
  )
}
