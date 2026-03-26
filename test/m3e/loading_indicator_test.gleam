import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/loading_indicator

pub fn basic_test() {
  let l = loading_indicator.new()

  let expected =
    element.element(
      "m3e-loading-indicator",
      [attribute.attribute("variant", "uncontained")],
      [],
    )

  loading_indicator.render(l, [], [])
  |> should.equal(expected)
}

pub fn variant_test() {
  let l =
    loading_indicator.new()
    |> loading_indicator.variant(loading_indicator.Contained)

  let expected =
    element.element(
      "m3e-loading-indicator",
      [attribute.attribute("variant", "contained")],
      [],
    )

  loading_indicator.render(l, [], [])
  |> should.equal(expected)

  let l2 =
    loading_indicator.new()
    |> loading_indicator.variant(loading_indicator.Uncontained)

  let expected2 =
    element.element(
      "m3e-loading-indicator",
      [attribute.attribute("variant", "uncontained")],
      [],
    )

  loading_indicator.render(l2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let l = loading_indicator.new()
  let child = element.element("span", [], [])

  let expected =
    element.element(
      "m3e-loading-indicator",
      [attribute.attribute("variant", "uncontained")],
      [child],
    )

  loading_indicator.render(l, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let l = loading_indicator.new()
  let attr = attribute.attribute("class", "custom")

  let expected =
    element.element(
      "m3e-loading-indicator",
      [attribute.attribute("variant", "uncontained"), attr],
      [],
    )

  loading_indicator.render(l, [attr], [])
  |> should.equal(expected)
}
