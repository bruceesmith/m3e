import gleam/int
import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import m3e/helpers

pub fn attribute_with_default_test() {
  helpers.attribute_with_default("test", "value", "default")
  |> should.equal(attribute.attribute("test", "value"))

  helpers.attribute_with_default("test", "default", "default")
  |> should.equal(attribute.none())
}

pub fn boolean_attribute_test() {
  helpers.boolean_attribute("test", True)
  |> should.equal(attribute.attribute("test", ""))

  helpers.boolean_attribute("test", False)
  |> should.equal(attribute.none())
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
  |> should.equal(attribute.attribute("name", "10"))

  helpers.option_attribute(None, name_fn, val_fn, Some(5))
  |> should.equal(attribute.attribute("name", "5"))

  helpers.option_attribute(None, name_fn, val_fn, None)
  |> should.equal(attribute.none())
}

pub fn slot_test() {
  helpers.slot("my-slot")
  |> should.equal(attribute.attribute("slot", "my-slot"))
}

pub fn positive_test() {
  helpers.positive_(10)
  |> should.equal(Ok(10))

  helpers.positive_(0)
  |> should.be_error

  helpers.positive_(-5)
  |> should.be_error
}

pub fn range_test() {
  helpers.range_(5, 0, 10)
  |> should.equal(Ok(5))

  helpers.range_(0, 0, 10)
  |> should.equal(Ok(0))

  helpers.range_(10, 0, 10)
  |> should.equal(Ok(10))

  helpers.range_(-1, 0, 10)
  |> should.be_error

  helpers.range_(11, 0, 10)
  |> should.be_error
}
