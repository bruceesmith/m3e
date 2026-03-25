import gleeunit/should

import lustre/attribute.{attribute}
import lustre/element.{element}

import m3e/state.{Disabled}
import m3e/textarea_autosize.{disabled, for, max_rows, min_rows, new, render}

pub fn textarea_autosize_basic_test() {
  let ta = new("test_id")
  let expected =
    element(
      "m3e-textarea-autosize",
      [
        attribute("for", "test_id"),
        attribute("max-rows", "0"),
        attribute("min-rows", "0"),
      ],
      [],
    )
  render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_full_test() {
  let ta =
    new("test_id")
    |> for("another_id")
    |> disabled(Disabled)
    |> max_rows(10)
    |> min_rows(2)

  let expected =
    element(
      "m3e-textarea-autosize",
      [
        attribute("for", "another_id"),
        attribute("disabled", ""),
        attribute("max-rows", "10"),
        attribute("min-rows", "2"),
      ],
      [],
    )
  render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_disabled_test() {
  let ta = new("test_id") |> disabled(Disabled)
  let expected =
    element(
      "m3e-textarea-autosize",
      [
        attribute("for", "test_id"),
        attribute("disabled", ""),
        attribute("max-rows", "0"),
        attribute("min-rows", "0"),
      ],
      [],
    )
  render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_for_test() {
  let ta = new("test_id") |> for("new_id")
  let expected =
    element(
      "m3e-textarea-autosize",
      [
        attribute("for", "new_id"),
        attribute("max-rows", "0"),
        attribute("min-rows", "0"),
      ],
      [],
    )
  render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_max_rows_test() {
  let ta = new("test_id") |> max_rows(20)
  let expected =
    element(
      "m3e-textarea-autosize",
      [
        attribute("for", "test_id"),
        attribute("max-rows", "20"),
        attribute("min-rows", "0"),
      ],
      [],
    )
  render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_min_rows_test() {
  let ta = new("test_id") |> min_rows(5)
  let expected =
    element(
      "m3e-textarea-autosize",
      [
        attribute("for", "test_id"),
        attribute("max-rows", "0"),
        attribute("min-rows", "5"),
      ],
      [],
    )
  render(ta, [], []) |> should.equal(expected)
}
