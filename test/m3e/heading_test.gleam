import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/heading

pub fn heading_test() {
  let h = heading.heading(False, heading.Large, heading.Display, "Hello")
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Hello")],
    )
  heading.element(h, []) |> should.equal(expected)
}

pub fn basic_test() {
  let h = heading.basic("World")
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("World")],
    )
  heading.element(h, []) |> should.equal(expected)
}

pub fn element_test() {
  let h = heading.heading(True, heading.Small, heading.Title, "Test")
  let result = heading.element(h, [])

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
  let h = heading.basic("Basic Test")
  let result = heading.element(h, [])

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
  let h = heading.basic("Emphasized")
  let expected_basic =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Emphasized")],
    )
  heading.element(h, []) |> should.equal(expected_basic)

  let h2 = heading.emphasized(h, True)
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
  heading.element(h2, []) |> should.equal(expected_emphasized)
}

pub fn size_test() {
  let h = heading.basic("Size")
  let h2 = heading.size(h, heading.Large)
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Size")],
    )
  heading.element(h2, []) |> should.equal(expected)

  let h3 = heading.size(h2, heading.Small)
  let expected_small =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Size")],
    )
  heading.element(h3, []) |> should.equal(expected_small)
}

pub fn variant_test() {
  let h = heading.basic("Variant")
  let h2 = heading.variant(h, heading.Headline)
  let expected =
    element.element(
      "m3e-heading",
      [
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "headline"),
      ],
      [html.text("Variant")],
    )
  heading.element(h2, []) |> should.equal(expected)
}

pub fn element_with_attributes_test() {
  let h = heading.basic("Test with Attributes")
  let custom_attributes = [
    attribute.attribute("id", "my-heading"),
    attribute.attribute("class", "custom-class"),
  ]
  let result = heading.element(h, custom_attributes)

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
