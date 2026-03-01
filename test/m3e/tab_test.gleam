import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/tab.{disabled, for, new, render, selected}

pub fn tab_new_test() {
  new()
  |> render([], [])
  |> should.equal(element("m3e-tab", [attribute("for", "")], []))
}

pub fn tab_full_test() {
  new()
  |> disabled(True)
  |> for("my-control")
  |> selected(True)
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
