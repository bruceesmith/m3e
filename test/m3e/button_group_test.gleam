import gleam/option.{Some}
import gleeunit/should

import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}

import m3e/button_group.{
  Connected, Standard, multi, new, render, render_config, size, variant,
}
import m3e/config.{Multi}

pub fn button_group_creation_test() {
  let bg =
    new()
    |> multi(Multi)
    |> size(Some(config.Medium))
    |> variant(Some(Connected))
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

  let bg2 = new()
  let expected2 =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [],
    )
  render(bg2, [], []) |> should.equal(expected2)
}

pub fn button_group_element_test() {
  let bg = new() |> size(Some(config.Small)) |> variant(Some(Standard))
  let expected =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [text("Child")],
    )

  bg |> render([], [text("Child")]) |> should.equal(expected)

  // Default values check
  let bg_defaults = new()
  let expected_defaults =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "standard")],
      [],
    )
  bg_defaults |> render([], []) |> should.equal(expected_defaults)
}

pub fn button_group_multi_test() {
  let bg =
    new() |> size(Some(config.Small)) |> variant(Some(Standard)) |> multi(Multi)

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

pub fn config_test() {
  let config =
    button_group.Config(
      multi: Multi,
      size: Some(config.Medium),
      variant: Some(Connected),
    )
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
  render_config(config, [], []) |> should.equal(expected)
}

pub fn button_group_size_test() {
  let bg = new() |> size(Some(config.Large))

  let expected =
    element(
      "m3e-button-group",
      [attribute("size", "large"), attribute("variant", "standard")],
      [],
    )
  bg |> render([], []) |> should.equal(expected)

  let bg2 = new() |> size(Some(config.ExtraSmall))
  let expected2 =
    element(
      "m3e-button-group",
      [attribute("size", "extra-small"), attribute("variant", "standard")],
      [],
    )
  bg2 |> render([], []) |> should.equal(expected2)
}

pub fn button_group_variant_test() {
  let bg = new() |> variant(Some(Connected))

  let expected =
    element(
      "m3e-button-group",
      [attribute("size", "small"), attribute("variant", "connected")],
      [],
    )
  bg |> render([], []) |> should.equal(expected)
}
