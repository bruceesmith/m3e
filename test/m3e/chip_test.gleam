import gleam/option.{None, Some}
import lustre/attribute
import lustre/element
import m3e/chip
import m3e/form_submission

pub fn default_config_test() {
  let assert chip.Config(form_submission: None, variant: chip.Outlined) =
    chip.default_config()
}

pub fn render_test() {
  let actual =
    chip.default_config()
    |> chip.from_config
    |> chip.render([], [element.text("Label")])

  let expected =
    element.element("m3e-chip", [attribute.attribute("variant", "outlined")], [
      element.text("Label"),
    ])

  let assert True = actual == expected
}

pub fn variant_setter_test() {
  let config = chip.Config(form_submission: None, variant: chip.Outlined)

  let actual =
    chip.from_config(config)
    |> chip.variant(chip.Elevated)
    |> chip.render([], [])

  let expected =
    element.element(
      "m3e-chip",
      [attribute.attribute("variant", "elevated")],
      [],
    )

  let assert True = actual == expected
}

pub fn form_submission_test() {
  let submission =
    form_submission.new()
    |> form_submission.name("group")
    |> form_submission.value("1")

  let actual =
    chip.default_config()
    |> chip.from_config
    |> chip.form(Some(submission))
    |> chip.render([], [])

  let expected =
    element.element(
      "m3e-chip",
      [
        attribute.attribute("variant", "outlined"),
        attribute.attribute("name", "group"),
        attribute.attribute("value", "1"),
      ],
      [],
    )

  let assert True = actual == expected
}

pub fn render_config_test() {
  let config = chip.Config(form_submission: None, variant: chip.Elevated)

  let actual = chip.render_config(config, [attribute.id("chip")], [])

  let expected =
    element.element(
      "m3e-chip",
      [
        attribute.attribute("variant", "elevated"),
        attribute.id("chip"),
      ],
      [],
    )

  let assert True = actual == expected
}

pub fn slot_test() {
  let icon_slot = chip.slot(chip.Icon)
  let expected = attribute.attribute("slot", "icon")

  let assert True = icon_slot == expected
}
