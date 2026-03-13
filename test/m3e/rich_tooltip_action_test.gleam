import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/rich_tooltip_action

// --- CONFIGURATION ---

pub fn default_config_test() {
  rich_tooltip_action.default_config()
  |> should.equal(rich_tooltip_action.Config(disable_restore_focus: False))
}

// --- CONSTRUCTORS ---

pub fn new_test() {
  rich_tooltip_action.new()
  |> rich_tooltip_action.render([], [])
  |> should.equal(element.element("m3e-rich-tooltip", [], []))
}

pub fn from_config_test() {
  let config = rich_tooltip_action.default_config()
  rich_tooltip_action.from_config(config)
  |> rich_tooltip_action.render([], [])
  |> should.equal(element.element("m3e-rich-tooltip", [], []))
}

// --- SETTERS ---

pub fn disable_restore_focus_test() {
  rich_tooltip_action.new()
  |> rich_tooltip_action.disable_restore_focus(True)
  |> rich_tooltip_action.render([], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [attribute.attribute("disable-restore-focus", "")],
      [],
    ),
  )
}

// --- RENDERING ---

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  rich_tooltip_action.new()
  |> rich_tooltip_action.disable_restore_focus(True)
  |> rich_tooltip_action.render(attrs, children)
  |> should.equal(element.element(
    "m3e-rich-tooltip",
    [
      attribute.attribute("disable-restore-focus", ""),
      attribute.class("custom-class"),
    ],
    children,
  ))
}

pub fn render_config_test() {
  let config = rich_tooltip_action.Config(disable_restore_focus: True)
  rich_tooltip_action.render_config(config, [], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [attribute.attribute("disable-restore-focus", "")],
      [],
    ),
  )
}
