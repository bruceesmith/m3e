import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/helpers.{boolean_attribute}
import m3e/state.{Disabled, Enabled}
import m3e/step.{
  Completed, Config, Editable, NotCompleted, NotEditable, NotOptional,
  NotSelected, Optional, Selected, completed, default_config, disabled, editable,
  for_, from_config, new, optional, render, render_config, selected,
}

pub fn step_new_test() {
  new("target-id")
  |> render([])
  |> should.equal(
    element.element("m3e-step", [attribute.attribute("for", "target-id")], [
      element.text(""),
    ]),
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
  |> render([])
  |> should.equal(
    element.element(
      "m3e-step",
      [
        attribute.attribute("completed", ""),
        attribute.attribute("disabled", ""),
        attribute.attribute("editable", ""),
        attribute.attribute("for", "new-id"),
        attribute.attribute("optional", ""),
        attribute.attribute("selected", ""),
      ],
      [element.text("Step 1")],
    ),
  )
}

pub fn default_config_test() {
  let default = default_config("a")
  let expected =
    Config(
      NotCompleted,
      Enabled,
      NotEditable,
      "a",
      NotOptional,
      NotSelected,
      "",
    )

  default |> should.equal(expected)
}

pub fn from_config_test() {
  let config =
    Config(Completed, Disabled, Editable, "b", Optional, Selected, "text")
  let actual = from_config(config)

  actual
  |> render([element.text("child")])
  |> should.equal(render_config(config, [element.text("child")]))
}

pub fn render_config_test() {
  let config =
    Config(Completed, Disabled, Editable, "c", Optional, Selected, "text")
  let actual = render_config(config, [element.text("child")])

  actual
  |> should.equal(
    element.element(
      "m3e-step",
      [
        boolean_attribute("completed", True),
        boolean_attribute("disabled", True),
        boolean_attribute("editable", True),
        attribute.attribute("for", "c"),
        boolean_attribute("optional", True),
        boolean_attribute("selected", True),
      ],
      [element.text("text"), element.text("child")],
    ),
  )
}
