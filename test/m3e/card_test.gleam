import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/card.{
  Elevated, Filled, Outlined, actionable, disabled, inline, new, orientation,
  render, variant,
}
import m3e/layout.{Horizontal, Vertical}
import m3e/state.{Disabled, Enabled}

pub fn card_creation_test() {
  let c =
    new()
    |> actionable(card.Actionable)
    |> disabled(Disabled)
    |> inline(card.Inline)
    |> orientation(Horizontal)
    |> variant(Outlined)

  let expected =
    element.element(
      "m3e-card",
      [
        attribute.attribute("actionable", ""),
        attribute.attribute("disabled", ""),
        attribute.attribute("inline", ""),
        attribute.attribute("orientation", "horizontal"),
        attribute.attribute("variant", "outlined"),
      ],
      [],
    )

  render(c, [], []) |> should.equal(expected)
}

pub fn card_element_test() {
  let c =
    new()
    |> actionable(card.Static)
    |> disabled(Enabled)
    |> inline(card.Block)
    |> orientation(Vertical)
    |> variant(Elevated)

  let expected =
    element.element(
      "m3e-card",
      [
        attribute.attribute("orientation", "vertical"),
        attribute.attribute("variant", "elevated"),
      ],
      [element.text("Content")],
    )

  render(c, [], [element.text("Content")]) |> should.equal(expected)
}

pub fn card_setters_test() {
  let c =
    new()
    |> actionable(card.Actionable)
    |> disabled(Disabled)
    |> inline(card.Inline)
    |> orientation(Horizontal)
    |> variant(Filled)

  let expected =
    element.element(
      "m3e-card",
      [
        attribute.attribute("actionable", ""),
        attribute.attribute("disabled", ""),
        attribute.attribute("inline", ""),
        attribute.attribute("orientation", "horizontal"),
        attribute.attribute("variant", "filled"),
      ],
      [],
    )

  render(c, [], []) |> should.equal(expected)
}
