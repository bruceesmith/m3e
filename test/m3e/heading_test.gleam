import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/heading

pub fn heading_test() {
  let h = heading.heading(False, heading.Large, heading.Display, "Hello")
  h.emphasized |> should.be_false()
  h.size |> should.equal(heading.Large)
  h.variant |> should.equal(heading.Display)
  h.text |> should.equal("Hello")
}

pub fn basic_test() {
  let h = heading.basic("World")
  h.emphasized |> should.be_false()
  h.size |> should.equal(heading.default_size)
  h.variant |> should.equal(heading.default_variant)
  h.text |> should.equal("World")
}

pub fn element_test() {
  let h = heading.heading(True, heading.Small, heading.Title, "Test")
  let result = heading.element(h)

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
  let result = heading.element(h)

  let expected =
    element.element(
      "m3e-heading",
      [
        // `emphasized` is false, so the `boolean_attribute` helper returns
        // `attribute.none()`, which results in no attribute being rendered.
        attribute.attribute("size", "medium"),
        attribute.attribute("variant", "display"),
      ],
      [html.text("Basic Test")],
    )

  result |> should.equal(expected)
}

pub fn emphasized_test() {
  let h = heading.basic("Emphasized")
  h.emphasized |> should.be_false()

  let h2 = heading.emphasized(h, True)
  h2.emphasized |> should.be_true()
  // Check other fields remain unchanged
  h2.size |> should.equal(h.size)
  h2.variant |> should.equal(h.variant)
  h2.text |> should.equal(h.text)

  let h3 = heading.emphasized(h2, False)
  h3.emphasized |> should.be_false()
}

pub fn size_test() {
  let h = heading.basic("Size")
  h.size |> should.equal(heading.Medium) // Default size

  let h2 = heading.size(h, heading.Large)
  h2.size |> should.equal(heading.Large)
  // Check other fields remain unchanged
  h2.emphasized |> should.equal(h.emphasized)
  h2.variant |> should.equal(h.variant)
  h2.text |> should.equal(h.text)

  let h3 = heading.size(h2, heading.Small)
  h3.size |> should.equal(heading.Small)
}

pub fn variant_test() {
  let h = heading.basic("Variant")
  h.variant |> should.equal(heading.Display) // Default variant

  let h2 = heading.variant(h, heading.Headline)
  h2.variant |> should.equal(heading.Headline)
  // Check other fields remain unchanged
  h2.emphasized |> should.equal(h.emphasized)
  h2.size |> should.equal(h.size)
  h2.text |> should.equal(h.text)

  let h3 = heading.variant(h2, heading.Label)
  h3.variant |> should.equal(heading.Label)

  let h4 = heading.variant(h3, heading.Title)
  h4.variant |> should.equal(heading.Title)
}