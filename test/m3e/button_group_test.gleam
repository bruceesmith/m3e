import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/button_group.{
  Connected, ExtraSmall, Large, Medium, Small, Standard, button_group, multi,
  render, size, variant,
}

pub fn button_group_creation_test() {
  let bg = button_group(True, Some(Medium), Some(Connected))
  let expected =
    element(
      "m3e-button-group",
      [
        attribute("multi", ""),
        attribute("size", "medium"),
        attribute("variant", "connected"),
      ],
      [],
    )
  render(bg, [], []) |> should.equal(expected)

  let bg2 = button_group(False, None, None)
  let expected2 =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [],
    )
  render(bg2, [], []) |> should.equal(expected2)
}

pub fn button_group_element_test() {
  let bg = button_group(False, Some(Small), Some(Standard))
  let expected =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [text("Child")],
    )

  bg |> render([], [text("Child")]) |> should.equal(expected)

  // Default values check
  let bg_defaults = button_group(False, None, None)
  let expected_defaults =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [],
    )
  bg_defaults |> render([], []) |> should.equal(expected_defaults)
}

pub fn button_group_multi_test() {
  let bg = button_group(False, Some(Small), Some(Standard)) |> multi(True)

  let expected =
    element(
      "m3e-button-group",
      [
        attribute("multi", ""),
        attribute("size", "small"),
        attribute("variant", "standard"),
      ],
      [],
    )
  bg |> render([], []) |> should.equal(expected)
}

pub fn button_group_size_test() {
  let bg = button_group(False, Some(Small), Some(Standard)) |> size(Some(Large))

  let expected =
    element(
      "m3e-button-group",
      [attribute("size", "large"), attribute("variant", "standard")],
      [],
    )
  bg |> render([], []) |> should.equal(expected)

  let bg2 =
    button_group(False, Some(Small), Some(Standard)) |> size(Some(ExtraSmall))
  let expected2 =
    element(
      "m3e-button-group",
      [attribute("size", "extra-small"), attribute("variant", "standard")],
      [],
    )
  bg2 |> render([], []) |> should.equal(expected2)
}

pub fn button_group_variant_test() {
  let bg =
    button_group(False, Some(Small), Some(Standard)) |> variant(Some(Connected))

  let expected =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "connected")],
      [],
    )
  bg |> render([], []) |> should.equal(expected)
}
