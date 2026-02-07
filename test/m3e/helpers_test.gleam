import gleam/int
import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute, none}
import m3e/helpers

pub fn boolean_attribute_test() {
  helpers.boolean_attribute("test", True)
  |> should.equal(attribute("test", ""))

  helpers.boolean_attribute("test", False)
  |> should.equal(none())
}

pub fn clamp_with_default_test() {
  helpers.clamp_with_default(5, 0, 10, 0)
  |> should.equal(5)

  helpers.clamp_with_default(-5, 0, 10, 0)
  |> should.equal(0)

  helpers.clamp_with_default(15, 0, 10, 0)
  |> should.equal(0)
}

pub fn option_attribute_test() {
  let name_fn = fn(_) { "name" }
  let val_fn = fn(x: Int) { int.to_string(x) }

  helpers.option_attribute(Some(10), name_fn, val_fn, None)
  |> should.equal(attribute("name", "10"))

  helpers.option_attribute(None, name_fn, val_fn, Some(5))
  |> should.equal(attribute("name", "5"))

  helpers.option_attribute(None, name_fn, val_fn, None)
  |> should.equal(none())
}

pub fn slot_test() {
  helpers.slot("my-slot")
  |> should.equal(attribute("slot", "my-slot"))
}
