import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element, text}
import m3e/step.{
  completed, disabled, editable, for_, new, optional, render, selected,
}

pub fn step_new_test() {
  new("target-id")
  |> render
  |> should.equal(
    element("m3e-step", [attribute("for", "target-id")], [text("")]),
  )
}

pub fn step_full_test() {
  new("id")
  |> completed(True)
  |> disabled(True)
  |> editable(True)
  |> for_("new-id")
  |> optional(True)
  |> selected(True)
  |> step.text("Step 1")
  |> render
  |> should.equal(
    element(
      "m3e-step",
      [
        attribute("completed", ""),
        attribute("disabled", ""),
        attribute("editable", ""),
        attribute("for", "new-id"),
        attribute("optional", ""),
        attribute("selected", ""),
      ],
      [text("Step 1")],
    ),
  )
}
