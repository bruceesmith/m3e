import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/helpers
import m3e/state.{Disabled, Enabled}
import m3e/step.{
  Completed, Config, Editable, NotCompleted, NotEditable, NotOptional,
  NotSelected, Optional, Selected,
}

pub fn step_new_test() {
  step.new("target-id")
  |> step.render([])
  |> should.equal(
    element.element("m3e-step", [attribute.attribute("for", "target-id")], [
      element.text(""),
    ]),
  )
}

pub fn step_full_test() {
  step.new("id")
  |> step.completed(True)
  |> step.disabled(True)
  |> step.editable(True)
  |> step.for_("new-id")
  |> step.optional(True)
  |> step.selected(True)
  |> step.text("Step 1")
  |> step.render([])
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
  let default = step.default_config("a")
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
  let actual = step.from_config(config)

  actual
  |> step.render([element.text("child")])
  |> should.equal(step.render_config(config, [element.text("child")]))
}

pub fn render_config_test() {
  let config =
    Config(Completed, Disabled, Editable, "c", Optional, Selected, "text")
  let actual = step.render_config(config, [element.text("child")])

  actual
  |> should.equal(
    element.element(
      "m3e-step",
      [
        helpers.boolean_attribute("completed", True),
        helpers.boolean_attribute("disabled", True),
        helpers.boolean_attribute("editable", True),
        attribute.attribute("for", "c"),
        helpers.boolean_attribute("optional", True),
        helpers.boolean_attribute("selected", True),
      ],
      [element.text("text"), element.text("child")],
    ),
  )
}
