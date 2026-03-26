import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/tab_panel.{id, new, render}

pub fn tab_panel_new_test() {
  new("panel-1")
  |> render([], [])
  |> should.equal(
    element.element("m3e-tab-panel", [attribute.attribute("id", "panel-1")], []),
  )
}

pub fn tab_panel_full_test() {
  new("original")
  |> id("new-id")
  |> render([attribute.attribute("class", "active")], [element.text("Content")])
  |> should.equal(
    element.element(
      "m3e-tab-panel",
      [
        attribute.attribute("id", "new-id"),
        attribute.attribute("class", "active"),
      ],
      [element.text("Content")],
    ),
  )
}
