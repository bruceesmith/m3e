import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/slide_group.{
  disabled, new, next_page_label, previous_page_label, render, threshold,
  vertical,
}

pub fn slide_group_creation_test() {
  let s = new()
  let expected =
    element(
      "m3e-slide-group",
      [
        attribute("next-page-label", "Next page"),
        attribute("previous-page-label", "Previous page"),
        attribute("threshold", "0"),
      ],
      [],
    )
  render(s, [], []) |> should.equal(expected)
}

pub fn slide_group_setters_test() {
  let s =
    new()
    |> disabled(True)
    |> next_page_label("Next")
    |> previous_page_label("Prev")
    |> threshold(100)
    |> vertical(True)

  let expected =
    element(
      "m3e-slide-group",
      [
        attribute("disabled", ""),
        attribute("next-page-label", "Next"),
        attribute("previous-page-label", "Prev"),
        attribute("threshold", "100"),
        attribute("vertical", ""),
      ],
      [text("Child")],
    )
  render(s, [], [text("Child")]) |> should.equal(expected)
}
