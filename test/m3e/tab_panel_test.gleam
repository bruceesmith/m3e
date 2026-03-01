import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/tab_panel.{id, new, render}

pub fn tab_panel_new_test() {
  new("panel-1")
  |> render([], [])
  |> should.equal(element("m3e-tab-panel", [attribute("id", "panel-1")], []))
}

pub fn tab_panel_full_test() {
  new("original")
  |> id("new-id")
  |> render([attribute("class", "active")], [element.text("Content")])
  |> should.equal(
    element(
      "m3e-tab-panel",
      [attribute("id", "new-id"), attribute("class", "active")],
      [element.text("Content")],
    ),
  )
}
