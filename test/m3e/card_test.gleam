import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/card.{Elevated, Filled, Outlined}
import m3e/layout.{Horizontal, Vertical}
import m3e/state.{Disabled, Enabled}

pub fn card_creation_test() {
  let c =
    card.new()
    |> card.actionable(card.Actionable)
    |> card.disabled(Disabled)
    |> card.inline(card.Inline)
    |> card.orientation(Horizontal)
    |> card.variant(Outlined)

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

  card.render(c, [], []) |> should.equal(expected)
}

pub fn card_element_test() {
  let c =
    card.new()
    |> card.actionable(card.Static)
    |> card.disabled(Enabled)
    |> card.inline(card.Block)
    |> card.orientation(Vertical)
    |> card.variant(Elevated)

  let expected =
    element.element(
      "m3e-card",
      [
        attribute.attribute("orientation", "vertical"),
        attribute.attribute("variant", "elevated"),
      ],
      [element.text("Content")],
    )

  card.render(c, [], [element.text("Content")]) |> should.equal(expected)
}

pub fn card_setters_test() {
  let c =
    card.new()
    |> card.actionable(card.Actionable)
    |> card.disabled(Disabled)
    |> card.inline(card.Inline)
    |> card.orientation(Horizontal)
    |> card.variant(Filled)

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

  card.render(c, [], []) |> should.equal(expected)
}
