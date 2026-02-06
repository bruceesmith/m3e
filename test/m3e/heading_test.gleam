import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import lustre/element/html
import m3e/heading.{
  Headline, Large, Small, Title, emphasized, new, render, size, variant,
}

pub fn heading_test() {
  let h = new("Hello") |> size(Large)
  let expected =
    element(
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
    element(
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
    |> emphasized(True)
    |> size(Small)
    |> variant(Title)

  let result = render(h, [])

  let expected =
    element(
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
    element(
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
    element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Emphasized")],
    )
  render(h, []) |> should.equal(expected_basic)

  let h2 = emphasized(h, True)
  let expected_emphasized =
    element(
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
  let h2 = size(h, Large)
  let expected =
    element(
      "m3e-heading",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Size")],
    )
  render(h2, []) |> should.equal(expected)

  let h3 = size(h2, Small)
  let expected_small =
    element(
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
    element(
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
    element(
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
