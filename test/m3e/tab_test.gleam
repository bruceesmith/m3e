import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/tab.{Selected, disabled, for, new, render, selected}
import m3e/types.{Disabled}

pub fn tab_new_test() {
  new()
  |> render([], [])
  |> should.equal(element("m3e-tab", [attribute("for", "")], []))
}

pub fn tab_full_test() {
  new()
  |> disabled(Disabled)
  |> for("my-control")
  |> selected(Selected)
  |> render([attribute("id", "t-1")], [element.text("Tab 1")])
  |> should.equal(
    element(
      "m3e-tab",
      [
        attribute("disabled", ""),
        attribute("for", "my-control"),
        attribute("selected", ""),
        attribute("id", "t-1"),
      ],
      [element.text("Tab 1")],
    ),
  )
}
