import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/list_option

// --- CONFIGURATION ---

pub fn default_config_test() {
  list_option.default_config()
  |> should.equal(list_option.Config(disabled: False, selected: False))
}

// --- CONSTRUCTORS ---

pub fn new_test() {
  list_option.new()
  |> list_option.render([], [])
  |> should.equal(element.element("m3e-list-option", [], []))
}

pub fn from_config_test() {
  let config = list_option.default_config()
  list_option.from_config(config)
  |> list_option.render([], [])
  |> should.equal(element.element("m3e-list-option", [], []))
}

// --- SETTERS ---

pub fn disabled_test() {
  list_option.new()
  |> list_option.disabled(True)
  |> list_option.render([], [])
  |> should.equal(
    element.element(
      "m3e-list-option",
      [attribute.attribute("disabled", "")],
      [],
    ),
  )
}

pub fn selected_test() {
  list_option.new()
  |> list_option.selected(True)
  |> list_option.render([], [])
  |> should.equal(
    element.element(
      "m3e-list-option",
      [attribute.attribute("selected", "")],
      [],
    ),
  )
}

// --- RENDERING ---

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  list_option.new()
  |> list_option.disabled(True)
  |> list_option.selected(True)
  |> list_option.render(attrs, children)
  |> should.equal(element.element(
    "m3e-list-option",
    [
      attribute.attribute("selected", ""),
      attribute.attribute("disabled", ""),
      attribute.class("custom-class"),
    ],
    children,
  ))
}

pub fn render_config_test() {
  let config = list_option.Config(disabled: True, selected: False)
  list_option.render_config(config, [], [])
  |> should.equal(
    element.element(
      "m3e-list-option",
      [attribute.attribute("disabled", "")],
      [],
    ),
  )
}

pub fn slot_test() {
  list_option.slot(list_option.Leading)
  |> should.equal(attribute.attribute("slot", "leading"))

  list_option.slot(list_option.Overline)
  |> should.equal(attribute.attribute("slot", "overline"))

  list_option.slot(list_option.SupportingText)
  |> should.equal(attribute.attribute("slot", "supporting-text"))

  list_option.slot(list_option.Trailing)
  |> should.equal(attribute.attribute("slot", "trailing"))
}
