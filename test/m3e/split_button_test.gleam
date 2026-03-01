import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/split_button.{
  Elevated, ExtraLarge, Large, Outlined, Tonal, new, render, size, variant,
}

pub fn split_button_new_test() {
  let leading = text("Leading")
  let trailing = text("Trailing")
  let sb = new(leading, trailing)

  let expected =
    element(
      "m3e-split-button",
      [attribute("size", "small"), attribute("variant", "filled")],
      [leading, trailing],
    )

  render(sb, []) |> should.equal(expected)
}

pub fn split_button_size_test() {
  let leading = text("L")
  let trailing = text("T")

  new(leading, trailing)
  |> size(ExtraLarge)
  |> render([])
  |> should.equal(
    element(
      "m3e-split-button",
      [attribute("size", "extra-large"), attribute("variant", "filled")],
      [leading, trailing],
    ),
  )

  new(leading, trailing)
  |> size(Large)
  |> render([])
  |> should.equal(
    element(
      "m3e-split-button",
      [attribute("size", "large"), attribute("variant", "filled")],
      [leading, trailing],
    ),
  )
}

pub fn split_button_variant_test() {
  let leading = text("L")
  let trailing = text("T")

  new(leading, trailing)
  |> variant(Elevated)
  |> render([])
  |> should.equal(
    element(
      "m3e-split-button",
      [attribute("size", "small"), attribute("variant", "elevated")],
      [leading, trailing],
    ),
  )

  new(leading, trailing)
  |> variant(Outlined)
  |> render([])
  |> should.equal(
    element(
      "m3e-split-button",
      [attribute("size", "small"), attribute("variant", "outlined")],
      [leading, trailing],
    ),
  )

  new(leading, trailing)
  |> variant(Tonal)
  |> render([])
  |> should.equal(
    element(
      "m3e-split-button",
      [attribute("size", "small"), attribute("variant", "tonal")],
      [leading, trailing],
    ),
  )
}

pub fn split_button_render_attributes_test() {
  let leading = text("L")
  let trailing = text("T")
  let sb = new(leading, trailing)

  let expected =
    element(
      "m3e-split-button",
      [
        attribute("size", "small"),
        attribute("variant", "filled"),
        attribute("id", "test-id"),
      ],
      [leading, trailing],
    )

  render(sb, [attribute("id", "test-id")]) |> should.equal(expected)
}

pub fn split_button_leading_trailing_update_test() {
  let l1 = text("L1")
  let t1 = text("T1")
  let l2 = text("L2")
  let t2 = text("T2")

  new(l1, t1)
  |> split_button.leading(l2)
  |> split_button.trailing(t2)
  |> render([])
  |> should.equal(
    element(
      "m3e-split-button",
      [attribute("size", "small"), attribute("variant", "filled")],
      [l2, t2],
    ),
  )
}
