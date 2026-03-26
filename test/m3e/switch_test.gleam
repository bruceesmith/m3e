import gleam/option.{Some}
import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/form_submission
import m3e/state.{Checked, Disabled}
import m3e/switch.{Both, Selected}

pub fn switch_basic_test() {
  let s = switch.new("test_id") |> switch.label(Some("Test Label"))
  let expected = [
    element.element(
      "m3e-switch",
      [attribute.id("test_id"), attribute.attribute("icons", "none")],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  switch.render(s, []) |> should.equal(expected)
}

pub fn switch_full_test() {
  let s =
    switch.new("test_id")
    |> switch.label(Some("Test Label"))
    |> switch.checked(Checked)
    |> switch.disabled(Disabled)
    |> switch.form(Some(
      form_submission.new()
      |> form_submission.name("key")
      |> form_submission.value("value"),
    ))
    |> switch.icon(Both)

  let expected = [
    element.element(
      "m3e-switch",
      [
        attribute.id("test_id"),
        attribute.attribute("icons", "both"),
        attribute.attribute("checked", ""),
        attribute.attribute("disabled", ""),
        attribute.attribute("name", "key"),
        attribute.attribute("value", "value"),
      ],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  switch.render(s, []) |> should.equal(expected)
}

pub fn switch_element_test() {
  let s =
    switch.new("test_id")
    |> switch.label(Some("Test Label"))
  let expected = [
    element.element(
      "m3e-switch",
      [attribute.id("test_id"), attribute.attribute("icons", "none")],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  s
  |> switch.render([])
  |> should.equal(expected)
}

pub fn switch_checked_test() {
  let s =
    switch.new("test_id")
    |> switch.label(Some("Test Label"))
    |> switch.checked(Checked)

  let expected = [
    element.element(
      "m3e-switch",
      [
        attribute.id("test_id"),
        attribute.attribute("icons", "none"),
        attribute.attribute("checked", ""),
      ],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  s
  |> switch.render([])
  |> should.equal(expected)
}

pub fn switch_disabled_test() {
  let s =
    switch.new("test_id")
    |> switch.label(Some("Test Label"))
    |> switch.disabled(Disabled)

  let expected = [
    element.element(
      "m3e-switch",
      [
        attribute.id("test_id"),
        attribute.attribute("icons", "none"),
        attribute.attribute("disabled", ""),
      ],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  s
  |> switch.render([])
  |> should.equal(expected)
}

pub fn switch_form_test() {
  let s =
    switch.new("test_id")
    |> switch.label(Some("Test Label"))
    |> switch.form(Some(
      form_submission.new()
      |> form_submission.name("some_key")
      |> form_submission.value("some_value"),
    ))

  let expected = [
    element.element(
      "m3e-switch",
      [
        attribute.id("test_id"),
        attribute.attribute("icons", "none"),
        attribute.attribute("name", "some_key"),
        attribute.attribute("value", "some_value"),
      ],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  s
  |> switch.render([])
  |> should.equal(expected)
}

pub fn switch_icon_test() {
  let s =
    switch.new("test_id")
    |> switch.label(Some("Test Label"))
    |> switch.icon(Both)

  let expected = [
    element.element(
      "m3e-switch",
      [attribute.id("test_id"), attribute.attribute("icons", "both")],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  s
  |> switch.render([])
  |> should.equal(expected)

  let s = s |> switch.icon(Selected)
  let expected = [
    element.element(
      "m3e-switch",
      [attribute.id("test_id"), attribute.attribute("icons", "selected")],
      [],
    ),
    element.element("label", [attribute.for("test_id")], [
      element.text("Test Label"),
    ]),
  ]
  s
  |> switch.render([])
  |> should.equal(expected)
}

pub fn render_with_label_test() {
  let s = switch.new("my-switch") |> switch.label(Some("My Label"))
  let expected = [
    element.element(
      "m3e-switch",
      [
        attribute.attribute("id", "my-switch"),
        attribute.attribute("icons", "none"),
      ],
      [],
    ),
    element.element("label", [attribute.attribute("for", "my-switch")], [
      element.text("My Label"),
    ]),
  ]

  s
  |> switch.render([])
  |> should.equal(expected)
}

pub fn render_without_label_test() {
  let s = switch.new("my-switch")
  let expected = [
    element.element(
      "m3e-switch",
      [
        attribute.attribute("id", "my-switch"),
        attribute.attribute("icons", "none"),
      ],
      [],
    ),
  ]

  s
  |> switch.render([])
  |> should.equal(expected)
}
