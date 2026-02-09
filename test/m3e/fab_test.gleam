import gleam/option.{Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/fab
import m3e/form_submitter_type as helpers

pub fn default_test() {
  fab.new()
  |> fab.render([], [])
  |> should.equal(
    element.element(
      "m3e-fab",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "primary-container"),
      ],
      [],
    ),
  )
}

pub fn extended_test() {
  fab.new()
  |> fab.extended(True)
  |> fab.extended_label(Some("Compose"))
  |> fab.render([], [element.text("icon")])
  |> should.equal(
    element.element(
      "m3e-fab",
      [
        attribute.attribute("extended", ""),
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "primary-container"),
      ],
      [
        element.element("span", [attribute.attribute("slot", "label")], [
          element.text("Compose"),
        ]),
        element.text("icon"),
      ],
    ),
  )
}

pub fn attributes_test() {
  fab.new()
  |> fab.disabled(True)
  |> fab.disabled_interactive(True)
  |> fab.lowered(True)
  |> fab.name(Some("test-fab"))
  |> fab.size(fab.Small)
  |> fab.type_(Some(helpers.Submit))
  |> fab.value(Some("submitted"))
  |> fab.variant(fab.Tertiary)
  |> fab.render([], [])
  |> should.equal(
    element.element(
      "m3e-fab",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("disabled-interactive", ""),
        attribute.attribute("lowered", ""),
        attribute.attribute("name", "test-fab"),
        attribute.attribute("size", "small"),
        attribute.attribute("type", "submit"),
        attribute.attribute("value", "submitted"),
        attribute.attribute("variant", "tertiary"),
      ],
      [],
    ),
  )
}
