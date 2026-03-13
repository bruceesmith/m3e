import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/expandable_list_item

// --- CONFIGURATION ---

pub fn default_config_test() {
  expandable_list_item.default_config()
  |> should.equal(expandable_list_item.Config(disabled: False, open: False))
}

// --- CONSTRUCTORS ---

pub fn new_test() {
  expandable_list_item.new()
  |> expandable_list_item.render([], [])
  |> should.equal(element.element("m3e-expandable-list-item", [], []))
}

pub fn from_config_test() {
  let config = expandable_list_item.default_config()
  expandable_list_item.from_config(config)
  |> expandable_list_item.render([], [])
  |> should.equal(element.element("m3e-expandable-list-item", [], []))
}

// --- SETTERS ---

pub fn disabled_test() {
  expandable_list_item.new()
  |> expandable_list_item.disabled(True)
  |> expandable_list_item.render([], [])
  |> should.equal(
    element.element(
      "m3e-expandable-list-item",
      [attribute.attribute("disabled", "")],
      [],
    ),
  )
}

pub fn open_test() {
  expandable_list_item.new()
  |> expandable_list_item.open(True)
  |> expandable_list_item.render([], [])
  |> should.equal(
    element.element(
      "m3e-expandable-list-item",
      [attribute.attribute("open", "")],
      [],
    ),
  )
}

// --- RENDERING ---

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  expandable_list_item.new()
  |> expandable_list_item.disabled(True)
  |> expandable_list_item.open(True)
  |> expandable_list_item.render(attrs, children)
  |> should.equal(element.element(
    "m3e-expandable-list-item",
    [
      attribute.attribute("disabled", ""),
      attribute.attribute("open", ""),
      attribute.class("custom-class"),
    ],
    children,
  ))
}

pub fn render_config_test() {
  let config = expandable_list_item.Config(disabled: True, open: False)
  expandable_list_item.render_config(config, [], [])
  |> should.equal(
    element.element(
      "m3e-expandable-list-item",
      [attribute.attribute("disabled", "")],
      [],
    ),
  )
}

pub fn slot_test() {
  expandable_list_item.slot(expandable_list_item.Items)
  |> should.equal(attribute.attribute("slot", "items"))

  expandable_list_item.slot(expandable_list_item.Leading)
  |> should.equal(attribute.attribute("slot", "leading"))

  expandable_list_item.slot(expandable_list_item.Overline)
  |> should.equal(attribute.attribute("slot", "overline"))

  expandable_list_item.slot(expandable_list_item.SupportingText)
  |> should.equal(attribute.attribute("slot", "supporting-text"))

  expandable_list_item.slot(expandable_list_item.ToggleIcon)
  |> should.equal(attribute.attribute("slot", "toggle-icon"))

  expandable_list_item.slot(expandable_list_item.Trailing)
  |> should.equal(attribute.attribute("slot", "trailing"))
}
