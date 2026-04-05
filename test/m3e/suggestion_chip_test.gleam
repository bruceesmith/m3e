import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/chip
import m3e/form_submission
import m3e/link
import m3e/state
import m3e/suggestion_chip

pub fn default_config_test() {
  let config = suggestion_chip.default_config()

  config.disabled |> should.equal(state.default_interaction)
  config.disabled_interactive |> should.equal(state.default_interaction)
  config.form_submission |> should.equal(None)
  config.link |> should.equal(None)
  config.variant |> should.equal(chip.default_variant)
}

pub fn render_default_test() {
  suggestion_chip.render(
    suggestion_chip.from_config(suggestion_chip.default_config()),
    [],
    [element.text("Suggestion")],
  )
  |> should.equal(
    element.element(
      "m3e-suggestion-chip",
      [attribute.attribute("variant", "outlined")],
      [element.text("Suggestion")],
    ),
  )
}

pub fn render_disabled_test() {
  suggestion_chip.render(
    suggestion_chip.disabled(
      suggestion_chip.from_config(suggestion_chip.default_config()),
      state.Disabled,
    ),
    [],
    [element.text("Disabled Suggestion")],
  )
  |> should.equal(
    element.element(
      "m3e-suggestion-chip",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Disabled Suggestion")],
    ),
  )
}

pub fn render_with_link_test() {
  let test_link = link.new("https://example.com")

  suggestion_chip.render(
    suggestion_chip.link(
      suggestion_chip.from_config(suggestion_chip.default_config()),
      Some(test_link),
    ),
    [],
    [element.text("Linked Suggestion")],
  )
  |> should.equal(
    element.element(
      "m3e-suggestion-chip",
      [
        attribute.attribute("href", "https://example.com"),
        attribute.attribute("target", "_self"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Linked Suggestion")],
    ),
  )
}

pub fn render_with_form_test() {
  let submission =
    form_submission.new()
    |> form_submission.name("suggestion")
    |> form_submission.value("accepted")

  suggestion_chip.render(
    suggestion_chip.form(
      suggestion_chip.from_config(suggestion_chip.default_config()),
      Some(submission),
    ),
    [],
    [element.text("Form Suggestion")],
  )
  |> should.equal(
    element.element(
      "m3e-suggestion-chip",
      [
        attribute.attribute("name", "suggestion"),
        attribute.attribute("value", "accepted"),
        attribute.attribute("variant", "outlined"),
      ],
      [element.text("Form Suggestion")],
    ),
  )
}

pub fn render_config_test() {
  let config =
    suggestion_chip.Config(
      disabled: state.default_interaction,
      disabled_interactive: state.default_interaction,
      form_submission: None,
      link: None,
      variant: chip.Elevated,
    )

  suggestion_chip.render_config(config, [attribute.id("suggestion-chip")], [
    element.text("Configured Suggestion"),
  ])
  |> should.equal(
    element.element(
      "m3e-suggestion-chip",
      [
        attribute.attribute("variant", "elevated"),
        attribute.id("suggestion-chip"),
      ],
      [element.text("Configured Suggestion")],
    ),
  )
}

pub fn slot_test() {
  suggestion_chip.slot(suggestion_chip.Icon)
  |> should.equal(attribute.attribute("slot", "icon"))
}
