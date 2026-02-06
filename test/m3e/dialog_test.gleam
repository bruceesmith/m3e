import gleam/option
import gleeunit
import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import lustre/element/html
import m3e/dialog

pub fn main() {
  gleeunit.main()
}

pub fn basic_render_test() {
  let content = [html.text("This is the dialog content.")]
  let id = "test-dialog"
  let header = "Test Header"

  dialog.basic(id, header)
  |> dialog.render([], content)
  |> should.equal(
    element("m3e-dialog", [attribute.id(id)], [
      html.span([attribute.attribute("slot", "header")], [html.text(header)]),
      html.text("This is the dialog content."),
    ]),
  )
}

pub fn properties_test() {
  let content = [html.text("Content")]
  let id = "prop-dialog"

  dialog.basic(id, "Initial")
  |> dialog.header("Confirmation")
  |> dialog.alert(True)
  |> dialog.render([], content)
  |> should.equal(
    element(
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

  dialog.basic(id, "Headline")
  |> dialog.alert(True)
  |> dialog.close_label(option.Some("Close"))
  |> dialog.no_focus_trap(True)
  |> dialog.disable_close(True)
  |> dialog.dismissible(True)
  |> dialog.actions([action])
  |> dialog.render([], content)
  |> should.equal(
    element(
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
