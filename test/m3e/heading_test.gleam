import gleeunit/should

import lustre/attribute
import lustre/element
import lustre/element/html

import m3e/config
import m3e/heading.{
  Config, Emphasized, Headline, Title, default_config, emphasized, new, render,
  render_config, size, variant,
}

pub fn heading_test() {
  let h = new("Hello") |> size(config.Large)
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Hello")],
    )
  render(h, []) |> should.equal(expected)
}

pub fn basic_test() {
  let h = new("World")
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("World")],
    )
  render(h, []) |> should.equal(expected)
}

pub fn element_test() {
  let h =
    new("Test")
    |> emphasized(Emphasized)
    |> size(config.Small)
    |> variant(Title)

  let result = render(h, [])

  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("emphasized", ""),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "title"),
      ],
      [html.text("Test")],
    )

  result |> should.equal(expected)
}

pub fn element_basic_test() {
  let h = new("Basic Test")
  let result = render(h, [])

  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Basic Test")],
    )

  result |> should.equal(expected)
}

pub fn emphasized_test() {
  let h = new("Emphasized")
  let expected_basic =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Emphasized")],
    )
  render(h, []) |> should.equal(expected_basic)

  let h2 = emphasized(h, Emphasized)
  let expected_emphasized =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("emphasized", ""),
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Emphasized")],
    )
  render(h2, []) |> should.equal(expected_emphasized)
}

pub fn size_test() {
  let h = new("Size")
  let h2 = size(h, config.Large)
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Size")],
    )
  render(h2, []) |> should.equal(expected)

  let h3 = size(h2, config.Small)
  let expected_small =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Size")],
    )
  render(h3, []) |> should.equal(expected_small)
}

pub fn variant_test() {
  let h = new("Variant")
  let h2 = variant(h, Headline)
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "headline"),
      ],
      [html.text("Variant")],
    )
  render(h2, []) |> should.equal(expected)
}

pub fn element_with_attributes_test() {
  let h = new("Test with Attributes")
  let custom_attributes = [
    attribute.attribute("id", "my-heading"),
    attribute.attribute("class", "custom-class"),
  ]
  let result = render(h, custom_attributes)

  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
        attribute.attribute("id", "my-heading"),
        attribute.attribute("class", "custom-class"),
      ],
      [html.text("Test with Attributes")],
    )

  result |> should.equal(expected)
}

pub fn render_config_test() {
  let config =
    Config(
      ..default_config(),
      text: "Config Text",
      emphasis: Emphasized,
      size: config.Small,
    )
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("emphasized", ""),
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Config Text")],
    )

  render_config(config, [])
  |> should.equal(expected)
}
