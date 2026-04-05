import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/assist_chip
import m3e/chip
import m3e/form_submission
import m3e/link
import m3e/state

pub fn default_config_test() {
  let config = assist_chip.default_config()

  config.disabled |> should.equal(state.default_interaction)
  config.disabled_interactive |> should.equal(state.default_interaction)
  config.form_submission |> should.equal(None)
  config.link |> should.equal(None)
  config.variant |> should.equal(chip.default_variant)
}

pub fn render_default_test() {
  assist_chip.render(assist_chip.from_config(assist_chip.default_config()), [], [
    element.text("Assist"),
  ])
  |> should.equal(
    element.element(
      "m3e-assist-chip",
      [attribute.attribute("variant", "outlined")],
      [element.text("Assist")],
    ),
  )
}

pub fn render_disabled_test() {
  assist_chip.render(
    assist_chip.disabled(
      assist_chip.from_config(assist_chip.default_config()),
      state.Disabled,
    ),
    [],
    [element.text("Disabled Assist")],
  )
  |> should.equal(
    element.element(
      "m3e-assist-chip",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Disabled Assist")],
    ),
  )
}

pub fn render_with_link_test() {
  let test_link = link.new("https://example.com")

  assist_chip.render(
    assist_chip.link(
      assist_chip.from_config(assist_chip.default_config()),
      Some(test_link),
    ),
    [],
    [element.text("Linked Assist")],
  )
  |> should.equal(
    element.element(
      "m3e-assist-chip",
      [
        attribute.attribute("href", "https://example.com"),
        attribute.attribute("target", "_self"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Linked Assist")],
    ),
  )
}

pub fn render_with_form_test() {
  let submission =
    form_submission.new()
    |> form_submission.name("action")
    |> form_submission.value("assist")

  assist_chip.render(
    assist_chip.form(
      assist_chip.from_config(assist_chip.default_config()),
      Some(submission),
    ),
    [],
    [element.text("Form Assist")],
  )
  |> should.equal(
    element.element(
      "m3e-assist-chip",
      [
        attribute.attribute("name", "action"),
        attribute.attribute("value", "assist"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Form Assist")],
    ),
  )
}

pub fn render_config_test() {
  let config =
    assist_chip.Config(
      disabled: state.default_interaction,
      disabled_interactive: state.default_interaction,
      form_submission: None,
      link: None,
      variant: chip.Elevated,
    )

  assist_chip.render_config(config, [attribute.id("assist-chip")], [
    element.text("Configured Assist"),
  ])
  |> should.equal(
    element.element(
      "m3e-assist-chip",
      [
        attribute.attribute("variant", "elevated"),
        attribute.id("assist-chip"),
      ],
      [element.text("Configured Assist")],
    ),
  )
}

pub fn slot_test() {
  assist_chip.slot(assist_chip.Icon)
  |> should.equal(attribute.attribute("slot", "icon"))
}
