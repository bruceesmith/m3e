import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/toc.{for, max_depth, new, render}

pub fn toc_basic_test() {
  let t = new("test_id")
  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("max-depth", "0"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toc_full_test() {
  let t =
    new("test_id")
    |> for("another_id")
    |> max_depth(3)

  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "another_id"),
        attribute.attribute("max-depth", "3"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toc_for_test() {
  let t = new("test_id") |> for("new_id")
  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "new_id"),
        attribute.attribute("max-depth", "0"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}

pub fn toc_max_depth_test() {
  let t = new("test_id") |> max_depth(5)
  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("max-depth", "5"),
      ],
      [],
    )
  render(t, [], []) |> should.equal(expected)
}
