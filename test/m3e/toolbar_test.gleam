import gleeunit/should

import lustre/attribute.{attribute}
import lustre/element.{element}

import m3e/layout.{Vertical}
import m3e/toolbar.{
  Raised, Rounded, Vibrant, elevated, new, render, shape, variant, vertical,
}

pub fn toolbar_basic_test() {
  let t = new()
  let expected =
    element(
      "m3e-toolbar",
      [
        attribute("shape", "square"),
        attribute("variant", "standard"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_full_test() {
  let t =
    new()
    |> elevated(Raised)
    |> shape(Rounded)
    |> variant(Vibrant)
    |> vertical(Vertical)

  let expected =
    element(
      "m3e-toolbar",
      [
        attribute("elevated", ""),
        attribute("shape", "rounded"),
        attribute("variant", "vibrant"),
        attribute("vertical", ""),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_elevated_test() {
  let t = new() |> elevated(Raised)
  let expected =
    element(
      "m3e-toolbar",
      [
        attribute("elevated", ""),
        attribute("shape", "square"),
        attribute("variant", "standard"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_shape_test() {
  let t = new() |> shape(Rounded)
  let expected =
    element(
      "m3e-toolbar",
      [
        attribute("shape", "rounded"),
        attribute("variant", "standard"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_variant_test() {
  let t = new() |> variant(Vibrant)
  let expected =
    element(
      "m3e-toolbar",
      [
        attribute("shape", "square"),
        attribute("variant", "vibrant"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_vertical_test() {
  let t = new() |> vertical(Vertical)
  let expected =
    element(
      "m3e-toolbar",
      [
        attribute("shape", "square"),
        attribute("variant", "standard"),
        attribute("vertical", ""),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}
