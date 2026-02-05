import gleeunit
import gleeunit/should
import lustre/attribute
import lustre/element
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
  |> dialog.element([], content)
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

  dialog.basic(id, "Initial")
  |> dialog.headline("Confirmation")
  |> dialog.alert(True)
  |> dialog.element([], content)
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
