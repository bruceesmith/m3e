import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/layout.{Vertical}
import m3e/toolbar.{Raised, Rounded, Vibrant}

pub fn toolbar_basic_test() {
  let t = toolbar.new()
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("shape", "square"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  toolbar.render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_full_test() {
  let t =
    toolbar.new()
    |> toolbar.elevated(Raised)
    |> toolbar.shape(Rounded)
    |> toolbar.variant(Vibrant)
    |> toolbar.vertical(Vertical)

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
  toolbar.render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_elevated_test() {
  let t = toolbar.new() |> toolbar.elevated(Raised)
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
  toolbar.render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_shape_test() {
  let t = toolbar.new() |> toolbar.shape(Rounded)
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("shape", "rounded"),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )
  toolbar.render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_variant_test() {
  let t = toolbar.new() |> toolbar.variant(Vibrant)
  let expected =
    element.element(
      "m3e-toolbar",
      [
        attribute.attribute("shape", "square"),
        attribute.attribute("variant", "vibrant"),
      ],
      [],
    )
  toolbar.render(t, [], []) |> should.equal(expected)
}

pub fn toolbar_vertical_test() {
  let t = toolbar.new() |> toolbar.vertical(Vertical)
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
  toolbar.render(t, [], []) |> should.equal(expected)
}
