import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/tab_panel

pub fn tab_panel_new_test() {
  tab_panel.new("panel-1")
  |> tab_panel.render([], [])
  |> should.equal(
    element.element("m3e-tab-panel", [attribute.attribute("id", "panel-1")], []),
  )
}

pub fn tab_panel_full_test() {
  tab_panel.new("original")
  |> tab_panel.id("new-id")
  |> tab_panel.render([attribute.attribute("class", "active")], [
    element.text("Content"),
  ])
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
