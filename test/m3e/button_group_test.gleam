import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html.{text}
import m3e/button_group.{
  Connected, ExtraSmall, Large, Medium, Small, Standard, button_group, element,
  multi, size, variant,
}

pub fn button_group_creation_test() {
  let bg = button_group(True, Some(Medium), Some(Connected))
  bg.multi |> should.be_true()
  bg.size |> should.equal(Some(Medium))
  bg.variant |> should.equal(Some(Connected))

  let bg2 = button_group(False, None, None)
  bg2.multi |> should.be_false()
  bg2.size |> should.equal(None)
  bg2.variant |> should.equal(None)
}

pub fn button_group_element_test() {
  let bg = button_group(False, Some(Small), Some(Standard))
  let expected =
    element.element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [text("Child")],
    )

  bg |> element([text("Child")]) |> should.equal(expected)

  // Default values check
  let bg_defaults = button_group(False, None, None)
  let expected_defaults =
    element.element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [],
    )
  bg_defaults |> element([]) |> should.equal(expected_defaults)
}

pub fn button_group_multi_test() {
  let bg = button_group(False, Some(Small), Some(Standard)) |> multi(True)
  bg.multi |> should.be_true()

  let expected =
    element.element(
      "m3e-button-group",
      [
        attribute("multi", ""),
        attribute("size", "small"),
        attribute("variant", "standard"),
      ],
      [],
    )
  bg |> element([]) |> should.equal(expected)
}

pub fn button_group_size_test() {
  let bg = button_group(False, Some(Small), Some(Standard)) |> size(Some(Large))
  bg.size |> should.equal(Some(Large))

  let expected =
    element.element(
      "m3e-button-group",
      [attribute("size", "large"), attribute("variant", "standard")],
      [],
    )
  bg |> element([]) |> should.equal(expected)

  let bg2 =
    button_group(False, Some(Small), Some(Standard)) |> size(Some(ExtraSmall))
  bg2.size |> should.equal(Some(ExtraSmall))
  let expected2 =
    element.element(
      "m3e-button-group",
      [attribute("size", "extra-small"), attribute("variant", "standard")],
      [],
    )
  bg2 |> element([]) |> should.equal(expected2)
}

pub fn button_group_variant_test() {
  let bg =
    button_group(False, Some(Small), Some(Standard)) |> variant(Some(Connected))
  bg.variant |> should.equal(Some(Connected))

  let expected =
    element.element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "connected")],
      [],
    )
  bg |> element([]) |> should.equal(expected)
}
