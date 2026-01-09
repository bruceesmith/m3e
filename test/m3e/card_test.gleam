import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/card

pub fn card_test() {
  let c = card.card(True, True, True, card.Horizontal, card.Outlined)
  c.actionable |> should.be_true()
  c.disabled |> should.be_true()
  c.inline |> should.be_true()
  c.orientation |> should.equal(card.Horizontal)
  c.variant |> should.equal(card.Outlined)
}

pub fn basic_test() {
  let c = card.basic()
  c.actionable |> should.be_false()
  c.disabled |> should.be_false()
  c.inline |> should.be_false()
  c.orientation |> should.equal(card.default_orientation)
  c.variant |> should.equal(card.default_variant)
}

pub fn element_test() {
  let c = card.card(True, False, True, card.Horizontal, card.Elevated)
  let result = card.element(c, [], [html.text("Content")])

  let expected =
    element.element(
      "m3e-card",
      [
        attribute.attribute("actionable", ""),
        // disabled is False, so no attribute
        attribute.attribute("inline", ""),
        attribute.attribute("orientation", "horizontal"),
        attribute.attribute("variant", "elevated"),
      ],
      [html.text("Content")],
    )

  result |> should.equal(expected)
}

pub fn element_basic_test() {
  let c = card.basic()
  let result = card.element(c, [], [])

  let expected =
    element.element(
      "m3e-card",
      [
        // actionable, disabled, inline are False
        attribute.attribute("orientation", "vertical"),
        attribute.attribute("variant", "filled"),
      ],
      [],
    )

  result |> should.equal(expected)
}

pub fn actionable_test() {
  let c = card.basic()
  c.actionable |> should.be_false()

  let c2 = card.actionable(c, True)
  c2.actionable |> should.be_true()
  // Check other fields
  c2.disabled |> should.equal(c.disabled)
  c2.variant |> should.equal(c.variant)

  let c3 = card.actionable(c2, False)
  c3.actionable |> should.be_false()
}

pub fn disabled_test() {
  let c = card.basic()
  c.disabled |> should.be_false()

  let c2 = card.disabled(c, True)
  c2.disabled |> should.be_true()
  // Check other fields
  c2.actionable |> should.equal(c.actionable)
  c2.variant |> should.equal(c.variant)

  let c3 = card.disabled(c2, False)
  c3.disabled |> should.be_false()
}

pub fn inline_test() {
  let c = card.basic()
  c.inline |> should.be_false()

  let c2 = card.inline(c, True)
  c2.inline |> should.be_true()
  // Check other fields
  c2.actionable |> should.equal(c.actionable)
  c2.orientation |> should.equal(c.orientation)

  let c3 = card.inline(c2, False)
  c3.inline |> should.be_false()
}

pub fn orientation_test() {
  let c = card.basic()
  c.orientation |> should.equal(card.Vertical)

  let c2 = card.orientation(c, card.Horizontal)
  c2.orientation |> should.equal(card.Horizontal)
  // Check other fields
  c2.inline |> should.equal(c.inline)
  c2.variant |> should.equal(c.variant)

  let c3 = card.orientation(c2, card.Vertical)
  c3.orientation |> should.equal(card.Vertical)
}

pub fn variant_test() {
  let c = card.basic()
  c.variant |> should.equal(card.Filled)

  let c2 = card.variant(c, card.Elevated)
  c2.variant |> should.equal(card.Elevated)
  // Check other fields
  c2.orientation |> should.equal(c.orientation)
  c2.disabled |> should.equal(c.disabled)

  let c3 = card.variant(c2, card.Outlined)
  c3.variant |> should.equal(card.Outlined)
}
