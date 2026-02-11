import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/loading_indicator

pub fn basic_test() {
  let l = loading_indicator.new()

  let expected =
    element(
      "m3e-loading-indicator",
      [attribute("variant", "uncontained")],
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
    element(
      "m3e-loading-indicator",
      [attribute("variant", "contained")],
      [],
    )

  loading_indicator.render(l, [], [])
  |> should.equal(expected)

  let l2 =
    loading_indicator.new()
    |> loading_indicator.variant(loading_indicator.Uncontained)

  let expected2 =
    element(
      "m3e-loading-indicator",
      [attribute("variant", "uncontained")],
      [],
    )

  loading_indicator.render(l2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let l = loading_indicator.new()
  let child = element("span", [], [])

  let expected =
    element(
      "m3e-loading-indicator",
      [attribute("variant", "uncontained")],
      [child],
    )

  loading_indicator.render(l, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let l = loading_indicator.new()
  let attr = attribute("class", "custom")

  let expected =
    element(
      "m3e-loading-indicator",
      [attribute("variant", "uncontained"), attr],
      [],
    )

  loading_indicator.render(l, [attr], [])
  |> should.equal(expected)
}
