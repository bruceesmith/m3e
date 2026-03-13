import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/list_variant
import m3e/selection_list

// --- CONFIGURATION ---

pub fn default_config_test() {
  selection_list.default_config()
  |> should.equal(selection_list.Config(
    disabled: False,
    hide_selection_indicator: False,
    multi: False,
    variant: list_variant.Standard,
  ))
}

// --- CONSTRUCTORS ---

pub fn new_test() {
  selection_list.new()
  |> selection_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-selection-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

pub fn from_config_test() {
  selection_list.from_config(selection_list.default_config())
  |> selection_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-selection-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

// --- SETTERS ---

pub fn disabled_test() {
  selection_list.new()
  |> selection_list.disabled(True)
  |> selection_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-selection-list",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("variant", "standard"),
      ],
      [],
    ),
  )
}

pub fn hide_selection_indicator_test() {
  selection_list.new()
  |> selection_list.hide_selection_indicator(True)
  |> selection_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-selection-list",
      [
        attribute.attribute("hide-selection-indicator", ""),
        attribute.attribute("variant", "standard"),
      ],
      [],
    ),
  )
}

pub fn multi_test() {
  selection_list.new()
  |> selection_list.multi(True)
  |> selection_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-selection-list",
      [
        attribute.attribute("multi", ""),
        attribute.attribute("variant", "standard"),
      ],
      [],
    ),
  )
}

pub fn variant_test() {
  selection_list.new()
  |> selection_list.variant(list_variant.Segmented)
  |> selection_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-selection-list",
      [attribute.attribute("variant", "segmented")],
      [],
    ),
  )
}

// --- RENDERING ---

pub fn render_config_test() {
  selection_list.render_config(selection_list.default_config(), [], [])
  |> should.equal(
    element.element(
      "m3e-selection-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  selection_list.new()
  |> selection_list.disabled(True)
  |> selection_list.multi(True)
  |> selection_list.render(attrs, children)
  |> should.equal(element.element(
    "m3e-selection-list",
    [
      attribute.attribute("disabled", ""),
      attribute.attribute("multi", ""),
      attribute.attribute("variant", "standard"),
      attribute.class("custom-class"),
    ],
    children,
  ))
}
