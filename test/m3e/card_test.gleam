import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}

import m3e/card.{
  Elevated, Filled, Outlined, actionable, disabled, inline, new, orientation,
  render, variant,
}
import m3e/layout.{Horizontal, Vertical}
import m3e/types.{Disabled, Enabled}

pub fn card_creation_test() {
  let c =
    new()
    |> actionable(card.Actionable)
    |> disabled(Disabled)
    |> inline(card.Inline)
    |> orientation(Horizontal)
    |> variant(Outlined)

  let expected =
    element(
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
    element(
      "m3e-card",
      [
        attribute("orientation", "vertical"),
        attribute("variant", "elevated"),
      ],
      [text("Content")],
    )

  render(c, [], [text("Content")]) |> should.equal(expected)
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
    element(
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

  render(c, [], []) |> should.equal(expected)
}
