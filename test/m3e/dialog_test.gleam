import gleam/option
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html

import m3e/config.{Dismissible}
import m3e/dialog.{Alert, CloseDisabled, NoFocusTrap}

pub fn basic_render_test() {
  let content = [html.text("This is the dialog content.")]
  let id = "test-dialog"
  let header = "Test Header"

  dialog.new(id, header)
  |> dialog.render([], content)
  |> should.equal(
    element.element("m3e-dialog", [attribute.id(id)], [
      html.span([attribute.attribute("slot", "header")], [html.text(header)]),
      html.text("This is the dialog content."),
    ]),
  )
}

pub fn properties_test() {
  let content = [html.text("Content")]
  let id = "prop-dialog"

  dialog.new(id, "Initial")
  |> dialog.header("Confirmation")
  |> dialog.alert(Alert)
  |> dialog.render([], content)
  |> should.equal(
    element.element(
      "m3e-dialog",
      [
        attribute.id(id),
        attribute.attribute("alert", ""),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          html.text("Confirmation"),
        ]),
        html.text("Content"),
      ],
    ),
  )
}

pub fn full_attributes_test() {
  let content = [html.text("Content")]
  let id = "full-dialog"
  let action = html.button([], [html.text("OK")])

  dialog.new(id, "Headline")
  |> dialog.alert(Alert)
  |> dialog.close_label(option.Some("Close"))
  |> dialog.focus_trap(NoFocusTrap)
  |> dialog.close_behavior(CloseDisabled)
  |> dialog.dismissibility(Dismissible)
  |> dialog.actions([action])
  |> dialog.render([], content)
  |> should.equal(
    element.element(
      "m3e-dialog",
      [
        attribute.id(id),
        attribute.attribute("alert", ""),
        attribute.attribute("close-label", "Close"),
        attribute.attribute("no-focus-trap", ""),
        attribute.attribute("disable-close", ""),
        attribute.attribute("dismissible", ""),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          html.text("Headline"),
        ]),
        html.div([attribute.attribute("slot", "actions")], [action]),
        html.text("Content"),
      ],
    ),
  )
}

pub fn render_config_test() {
  let id = "config-dialog"
  let header = "Config Headline"
  let content = [html.text("Config Content")]

  let config =
    dialog.Config(
      ..dialog.default_config(),
      id: id,
      header: header,
      alert: Alert,
      dismissibility: Dismissible,
    )

  dialog.render_config(config, [], content)
  |> should.equal(
    element.element(
      "m3e-dialog",
      [
        attribute.id(id),
        attribute.attribute("alert", ""),
        attribute.attribute("dismissible", ""),
      ],
      [
        html.span([attribute.attribute("slot", "header")], [
          html.text(header),
        ]),
        html.text("Config Content"),
      ],
    ),
  )
}
