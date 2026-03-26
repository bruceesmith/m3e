import gleam/option.{Some}
import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/badge.{Before, Below, badge_position, for, label, new, render, size}
import m3e/config

pub fn badge_basic_test() {
  let b = new("Test Badge")
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test Badge")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_full_test() {
  let b =
    new("Original Label")
    |> for(Some("element_id"))
    |> size(config.Large)
    |> badge_position(Below)
    |> label("Final Label")

  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("for", "element_id"),
        attribute.attribute("size", "large"),
        attribute.attribute("position", "below"),
      ],
      [element.text("Final Label")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_size_test() {
  let b = new("Test") |> size(config.Small)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test")],
    )
  render(b) |> should.equal(expected)

  let b = b |> size(config.Large)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test")],
    )
  render(b) |> should.equal(expected)

  let b = b |> size(config.Medium)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_position_test() {
  let b = new("Test") |> badge_position(Before)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "before"),
      ],
      [element.text("Test")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_for_test() {
  let b = new("Test") |> for(Some("other_element"))
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("for", "other_element"),
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test")],
    )
  render(b) |> should.equal(expected)
}

pub fn badge_label_test() {
  let b = new("Test") |> label("New Label")
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("New Label")],
    )
  render(b) |> should.equal(expected)
}
