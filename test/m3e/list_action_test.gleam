import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/link
import m3e/list_action

// --- CONFIGURATION ---

pub fn default_config_test() {
  list_action.default_config()
  |> should.equal(list_action.Config(disabled: False, link: link.new("")))
}

// --- CONSTRUCTORS ---

pub fn new_test() {
  list_action.new()
  |> list_action.render([], [])
  |> should.equal(element.element("m3e-list-action", [], []))
}

pub fn from_config_test() {
  let config = list_action.default_config()
  list_action.from_config(config)
  |> list_action.render([], [])
  |> should.equal(element.element("m3e-list-action", [], []))
}

// --- SETTERS ---

pub fn disabled_test() {
  list_action.new()
  |> list_action.disabled(True)
  |> list_action.render([], [])
  |> should.equal(
    element.element(
      "m3e-list-action",
      [attribute.attribute("disabled", "")],
      [],
    ),
  )
}

// --- RENDERING ---

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  list_action.new()
  |> list_action.disabled(True)
  |> list_action.render(attrs, children)
  |> should.equal(element.element(
    "m3e-list-action",
    [attribute.attribute("disabled", ""), attribute.class("custom-class")],
    children,
  ))
}

pub fn render_config_test() {
  let config = list_action.Config(disabled: True, link: link.new(""))
  list_action.render_config(config, [], [])
  |> should.equal(
    element.element(
      "m3e-list-action",
      [attribute.attribute("disabled", "")],
      [],
    ),
  )
}

pub fn slot_test() {
  list_action.slot(list_action.Leading)
  |> should.equal(attribute.attribute("slot", "leading"))

  list_action.slot(list_action.Overline)
  |> should.equal(attribute.attribute("slot", "overline"))

  list_action.slot(list_action.SupportingText)
  |> should.equal(attribute.attribute("slot", "supporting-text"))

  list_action.slot(list_action.Trailing)
  |> should.equal(attribute.attribute("slot", "trailing"))
}
