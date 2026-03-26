import gleam/option.{Some}
import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/badge.{Before, Below}
import m3e/config

pub fn badge_basic_test() {
  let b = badge.new("Test Badge")
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test Badge")],
    )
  badge.render(b) |> should.equal(expected)
}

pub fn badge_full_test() {
  let b =
    badge.new("Original Label")
    |> badge.for(Some("element_id"))
    |> badge.size(config.Large)
    |> badge.badge_position(Below)
    |> badge.label("Final Label")

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
  badge.render(b) |> should.equal(expected)
}

pub fn badge_size_test() {
  let b = badge.new("Test") |> badge.size(config.Small)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test")],
    )
  badge.render(b) |> should.equal(expected)

  let b = b |> badge.size(config.Large)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test")],
    )
  badge.render(b) |> should.equal(expected)

  let b = b |> badge.size(config.Medium)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("Test")],
    )
  badge.render(b) |> should.equal(expected)
}

pub fn badge_position_test() {
  let b = badge.new("Test") |> badge.badge_position(Before)
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "before"),
      ],
      [element.text("Test")],
    )
  badge.render(b) |> should.equal(expected)
}

pub fn badge_for_test() {
  let b = badge.new("Test") |> badge.for(Some("other_element"))
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
  badge.render(b) |> should.equal(expected)
}

pub fn badge_label_test() {
  let b = badge.new("Test") |> badge.label("New Label")
  let expected =
    element.element(
      "m3e-badge",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("position", "above-after"),
      ],
      [element.text("New Label")],
    )
  badge.render(b) |> should.equal(expected)
}
