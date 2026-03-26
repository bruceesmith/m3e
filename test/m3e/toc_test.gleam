import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/toc

pub fn toc_basic_test() {
  let t = toc.new("test_id")
  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("max-depth", "0"),
      ],
      [],
    )
  toc.render(t, [], []) |> should.equal(expected)
}

pub fn toc_full_test() {
  let t =
    toc.new("test_id")
    |> toc.for("another_id")
    |> toc.max_depth(3)

  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "another_id"),
        attribute.attribute("max-depth", "3"),
      ],
      [],
    )
  toc.render(t, [], []) |> should.equal(expected)
}

pub fn toc_for_test() {
  let t = toc.new("test_id") |> toc.for("new_id")
  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "new_id"),
        attribute.attribute("max-depth", "0"),
      ],
      [],
    )
  toc.render(t, [], []) |> should.equal(expected)
}

pub fn toc_max_depth_test() {
  let t = toc.new("test_id") |> toc.max_depth(5)
  let expected =
    element.element(
      "m3e-toc",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("max-depth", "5"),
      ],
      [],
    )
  toc.render(t, [], []) |> should.equal(expected)
}
