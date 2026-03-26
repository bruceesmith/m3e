import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/state.{Disabled}
import m3e/textarea_autosize

pub fn textarea_autosize_basic_test() {
  let ta = textarea_autosize.new("test_id")
  let expected =
    element.element(
      "m3e-textarea-autosize",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("max-rows", "0"),
        attribute.attribute("min-rows", "0"),
      ],
      [],
    )
  textarea_autosize.render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_full_test() {
  let ta =
    textarea_autosize.new("test_id")
    |> textarea_autosize.for("another_id")
    |> textarea_autosize.disabled(Disabled)
    |> textarea_autosize.max_rows(10)
    |> textarea_autosize.min_rows(2)

  let expected =
    element.element(
      "m3e-textarea-autosize",
      [
        attribute.attribute("for", "another_id"),
        attribute.attribute("disabled", ""),
        attribute.attribute("max-rows", "10"),
        attribute.attribute("min-rows", "2"),
      ],
      [],
    )
  textarea_autosize.render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_disabled_test() {
  let ta =
    textarea_autosize.new("test_id") |> textarea_autosize.disabled(Disabled)
  let expected =
    element.element(
      "m3e-textarea-autosize",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("disabled", ""),
        attribute.attribute("max-rows", "0"),
        attribute.attribute("min-rows", "0"),
      ],
      [],
    )
  textarea_autosize.render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_for_test() {
  let ta = textarea_autosize.new("test_id") |> textarea_autosize.for("new_id")
  let expected =
    element.element(
      "m3e-textarea-autosize",
      [
        attribute.attribute("for", "new_id"),
        attribute.attribute("max-rows", "0"),
        attribute.attribute("min-rows", "0"),
      ],
      [],
    )
  textarea_autosize.render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_max_rows_test() {
  let ta = textarea_autosize.new("test_id") |> textarea_autosize.max_rows(20)
  let expected =
    element.element(
      "m3e-textarea-autosize",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("max-rows", "20"),
        attribute.attribute("min-rows", "0"),
      ],
      [],
    )
  textarea_autosize.render(ta, [], []) |> should.equal(expected)
}

pub fn textarea_autosize_min_rows_test() {
  let ta = textarea_autosize.new("test_id") |> textarea_autosize.min_rows(5)
  let expected =
    element.element(
      "m3e-textarea-autosize",
      [
        attribute.attribute("for", "test_id"),
        attribute.attribute("max-rows", "0"),
        attribute.attribute("min-rows", "5"),
      ],
      [],
    )
  textarea_autosize.render(ta, [], []) |> should.equal(expected)
}
