import gleam/option.{Some}
import gleeunit/should

import lustre/attribute.{attribute}
import lustre/element.{element, text}

import m3e/badge.{
  Before, Below, Large, Medium, Small, badge_position, for, label, new, render,
  size,
}

pub fn badge_basic_test() {
  let b = new("Test Badge")
  let expected =
    element(
      "m3e-badge",
      [
        attribute("size", "medium"),
        attribute("position", "above-after"),
      ],
      [text("Test Badge")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_full_test() {
  let b =
    new("Original Label")
    |> for(Some("element_id"))
    |> size(Large)
    |> badge_position(Below)
    |> label("Final Label")

  let expected =
    element(
      "m3e-badge",
      [
        attribute("for", "element_id"),
        attribute("size", "large"),
        attribute("position", "below"),
      ],
      [text("Final Label")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_size_test() {
  let b = new("Test") |> size(Small)
  let expected =
    element(
      "m3e-badge",
      [
        attribute("size", "small"),
        attribute("position", "above-after"),
      ],
      [text("Test")],
    )
  render(b) |> should.equal(expected)

  let b = b |> size(Large)
  let expected =
    element(
      "m3e-badge",
      [
        attribute("size", "large"),
        attribute("position", "above-after"),
      ],
      [text("Test")],
    )
  render(b) |> should.equal(expected)

  let b = b |> size(Medium)
  let expected =
    element(
      "m3e-badge",
      [
        attribute("size", "medium"),
        attribute("position", "above-after"),
      ],
      [text("Test")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_position_test() {
  let b = new("Test") |> badge_position(Before)
  let expected =
    element(
      "m3e-badge",
      [
        attribute("size", "medium"),
        attribute("position", "before"),
      ],
      [text("Test")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_for_test() {
  let b = new("Test") |> for(Some("other_element"))
  let expected =
    element(
      "m3e-badge",
      [
        attribute("for", "other_element"),
        attribute("size", "medium"),
        attribute("position", "above-after"),
      ],
      [text("Test")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_label_test() {
  let b = new("Test") |> label("New Label")
  let expected =
    element(
      "m3e-badge",
      [
        attribute("size", "medium"),
        attribute("position", "above-after"),
      ],
      [text("New Label")],
    )
  render(b) |> should.equal(expected)
}
