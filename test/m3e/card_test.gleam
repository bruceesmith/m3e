import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html.{text}
import m3e/card.{
  Elevated, Filled, Horizontal, Outlined, Vertical, actionable, basic, card,
  disabled, element, inline, orientation, variant,
}

pub fn card_creation_test() {
  let c = card(True, True, True, Horizontal, Outlined)

  let expected =
    element.element(
      "m3e-card",
      [
        attribute("actionable", ""),
        attribute("disabled", ""),
        attribute("inline", ""),
        attribute("orientation", "horizontal"),
        attribute("variant", "outlined"),
      ],
      [],
    )

  element(c, [], []) |> should.equal(expected)
}

pub fn card_element_test() {
  let c =
    basic()
    |> actionable(False)
    |> disabled(False)
    |> inline(False)
    |> orientation(Vertical)
    |> variant(Elevated)

  let expected =
    element.element(
      "m3e-card",
      [
        attribute("orientation", "vertical"),
        attribute("variant", "elevated"),
      ],
      [text("Content")],
    )

  element(c, [], [text("Content")]) |> should.equal(expected)
}

pub fn card_setters_test() {
  let c =
    basic()
    |> actionable(True)
    |> disabled(True)
    |> inline(True)
    |> orientation(Horizontal)
    |> variant(Filled)

  let expected =
    element.element(
      "m3e-card",
      [
        attribute("actionable", ""),
        attribute("disabled", ""),
        attribute("inline", ""),
        attribute("orientation", "horizontal"),
        attribute("variant", "filled"),
      ],
      [],
    )

  element(c, [], []) |> should.equal(expected)
}
