import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/layout.{Vertical}
import m3e/toolbar.{
  Raised, Rounded, Vibrant, elevated, new, render, shape, variant, vertical,
}

pub fn toolbar_basic_test() {
  let t = new()
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("shape", "square"),
        attribute.attribute("variant", "standard"),
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
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("elevated", ""),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("variant", "vibrant"),
        attribute.attribute("vertical", ""),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_elevated_test() {
  let t = new() |> elevated(Raised)
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("elevated", ""),
        attribute.attribute("shape", "square"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_shape_test() {
  let t = new() |> shape(Rounded)
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("shape", "rounded"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_variant_test() {
  let t = new() |> variant(Vibrant)
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("shape", "square"),
        attribute.attribute("variant", "vibrant"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_vertical_test() {
  let t = new() |> vertical(Vertical)
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("shape", "square"),
        attribute.attribute("variant", "standard"),
        attribute.attribute("vertical", ""),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}
