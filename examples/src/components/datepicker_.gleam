import gleam/option.{Some}

import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

import m3e/datepicker
import m3e/datepicker_toggle
import m3e/datepicker_variant
import m3e/form_field
import m3e/form_field_variant
import m3e/icon
import m3e/icon_button

import model
import msg.{type Msg}
import package.{type Package, Package}
import view_helpers

/// datepicker displays all facets of the M3E Datepicker wrapper component
///
fn datepicker(model: model.Model) -> Element(Msg) {
  view_helpers.page([
    view_helpers.panel(model, "Basic Usage", basic_usage),
  ])
}

fn basic_usage(_: model.Model) -> Element(Msg) {
  html.div([], [
    form_field.new()
      |> form_field.variant(form_field_variant.Outlined)
      |> form_field.render([], [
        html.label([attribute.for("fld1")], [
          element.text("Date Field"),
        ]),
        html.input([attribute.id("fld1"), attribute.autocomplete("off")]),
        icon_button.new()
          |> icon_button.render([form_field.slot(form_field.Suffix)], [
            icon.new() |> icon.name("calendar_today") |> icon.render([], []),
            datepicker_toggle.new(Some("datepicker1"))
              |> datepicker_toggle.render([], []),
          ]),
        html.span([form_field.slot(form_field.Hint)], [
          element.text("MM/DD/YYYY"),
        ]),
      ]),
    datepicker.new()
      |> datepicker.variant(datepicker_variant.Auto)
      |> datepicker.render([attribute.id("datepicker1")], []),
  ])
}

/// package() describes the calendar showcase in the standard Package record format
///
pub fn package() -> Package {
  Package(
    state: model.Datepicker,
    label: "Datepicker",
    view: datepicker,
    msg: msg.DatepickerSelected("#datepicker1", "#fld1"),
  )
}
