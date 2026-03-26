import gleam/option.{Some}
import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/button_group.{Connected, Standard}
import m3e/config.{Multi}

pub fn button_group_creation_test() {
  let bg =
    button_group.new()
    |> button_group.multi(Multi)
    |> button_group.size(Some(config.Medium))
    |> button_group.variant(Some(Connected))
  let expected =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("multi", ""),
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "connected"),
      ],
      [],
    )
  button_group.render(bg, [], []) |> should.equal(expected)

  let bg2 = button_group.new()
  let expected2 =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  button_group.render(bg2, [], []) |> should.equal(expected2)
}

pub fn button_group_element_test() {
  let bg =
    button_group.new()
    |> button_group.size(Some(config.Small))
    |> button_group.variant(Some(Standard))
  let expected =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
      ],
      [element.text("Child")],
    )

  bg
  |> button_group.render([], [element.text("Child")])
  |> should.equal(expected)

  // Default values check
  let bg_defaults = button_group.new()
  let expected_defaults =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  bg_defaults |> button_group.render([], []) |> should.equal(expected_defaults)
}

pub fn button_group_multi_test() {
  let bg =
    button_group.new()
    |> button_group.size(Some(config.Small))
    |> button_group.variant(Some(Standard))
    |> button_group.multi(Multi)

  let expected =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("multi", ""),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  bg |> button_group.render([], []) |> should.equal(expected)
}

pub fn config_test() {
  let config =
    button_group.Config(
      multi: Multi,
      size: Some(config.Medium),
      variant: Some(Connected),
    )
  let expected =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("multi", ""),
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "connected"),
      ],
      [],
    )
  button_group.render_config(config, [], []) |> should.equal(expected)
}

pub fn button_group_size_test() {
  let bg = button_group.new() |> button_group.size(Some(config.Large))

  let expected =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  bg |> button_group.render([], []) |> should.equal(expected)

  let bg2 = button_group.new() |> button_group.size(Some(config.ExtraSmall))
  let expected2 =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("size", "extra-small"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  bg2 |> button_group.render([], []) |> should.equal(expected2)
}

pub fn button_group_variant_test() {
  let bg = button_group.new() |> button_group.variant(Some(Connected))

  let expected =
    element.element(
      "m3e-button-group",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "connected"),
      ],
      [],
    )
  bg |> button_group.render([], []) |> should.equal(expected)
}
