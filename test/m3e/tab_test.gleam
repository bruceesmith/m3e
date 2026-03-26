import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/state.{Disabled}
import m3e/tab.{Selected}

pub fn tab_new_test() {
  tab.new()
  |> tab.render([], [])
  |> should.equal(
    element.element("m3e-tab", [attribute.attribute("for", "")], []),
  )
}

pub fn tab_full_test() {
  tab.new()
  |> tab.disabled(Disabled)
  |> tab.for("my-control")
  |> tab.selected(Selected)
  |> tab.render([attribute.attribute("id", "t-1")], [element.text("Tab 1")])
  |> should.equal(
    element.element(
      "m3e-tab",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("for", "my-control"),
        attribute.attribute("selected", ""),
        attribute.attribute("id", "t-1"),
      ],
      [element.text("Tab 1")],
    ),
  )
}
