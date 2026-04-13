import gleam/option.{Some}
import gleam/result
import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/calendar
import m3e/datepicker
import m3e/datetime

pub fn default_config_test() {
  let config = datepicker.default_config()
  config.clearable |> should.equal(False)
  config.label |> should.equal("Select date")
}

pub fn new_test() {
  let dp = datepicker.new()
  datepicker.render(dp, [])
  |> should.equal(
    element.element(
      "m3e-datepicker",
      [attribute.attribute("variant", "auto")],
      [],
    ),
  )
}

pub fn from_config_test() {
  let config =
    datepicker.Config(
      ..datepicker.default_config(),
      variant: datepicker.Modal,
      clearable: True,
      label: "My Date",
    )
  let dp = datepicker.from_config(config)

  datepicker.render(dp, [])
  |> should.equal(
    element.element(
      "m3e-datepicker",
      [
        attribute.attribute("variant", "modal"),
        attribute.attribute("clearable", ""),
        attribute.attribute("label", "My Date"),
      ],
      [],
    ),
  )
}

pub fn setters_test() {
  let date =
    datetime.from_string("2023-01-01")
    |> result.lazy_unwrap(fn() { panic as "Invalid date" })
  let cal = calendar.new() |> calendar.date(Some(date))

  let dp =
    datepicker.new()
    |> datepicker.variant(datepicker.Docked)
    |> datepicker.clearable(True)
    |> datepicker.clear_label("C")
    |> datepicker.confirm_label("OK")
    |> datepicker.dismiss_label("D")
    |> datepicker.label("L")
    |> datepicker.calendar(cal)

  datepicker.render(dp, [])
  |> should.equal(
    element.element(
      "m3e-datepicker",
      [
        attribute.attribute("variant", "docked"),
        attribute.attribute("clearable", ""),
        attribute.attribute("clear-label", "C"),
        attribute.attribute("dismiss-label", "D"),
        attribute.attribute("label", "L"),
        attribute.attribute("date", "2023-01-01"),
      ],
      [],
    ),
  )
}

pub fn render_config_test() {
  let config = datepicker.default_config()
  datepicker.render_config(config, [])
  |> should.equal(datepicker.render(datepicker.new(), []))
}
