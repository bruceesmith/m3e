import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/config
import m3e/split_button.{Elevated, Outlined, Tonal, new, render, size, variant}

pub fn split_button_new_test() {
  let leading = element.text("Leading")
  let trailing = element.text("Trailing")
  let sb = new(leading, trailing)

  let expected =
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "filled"),
      ],
      [leading, trailing],
    )

  render(sb, []) |> should.equal(expected)
}

pub fn split_button_size_test() {
  let leading = element.text("L")
  let trailing = element.text("T")

  new(leading, trailing)
  |> size(config.ExtraLarge)
  |> render([])
  |> should.equal(
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "extra-large"),
        attribute.attribute("variant", "filled"),
      ],
      [leading, trailing],
    ),
  )

  new(leading, trailing)
  |> size(config.Large)
  |> render([])
  |> should.equal(
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "large"),
        attribute.attribute("variant", "filled"),
      ],
      [leading, trailing],
    ),
  )
}

pub fn split_button_variant_test() {
  let leading = element.text("L")
  let trailing = element.text("T")

  new(leading, trailing)
  |> variant(Elevated)
  |> render([])
  |> should.equal(
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "elevated"),
      ],
      [leading, trailing],
    ),
  )

  new(leading, trailing)
  |> variant(Outlined)
  |> render([])
  |> should.equal(
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "outlined"),
      ],
      [leading, trailing],
    ),
  )

  new(leading, trailing)
  |> variant(Tonal)
  |> render([])
  |> should.equal(
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "tonal"),
      ],
      [leading, trailing],
    ),
  )
}

pub fn split_button_render_attributes_test() {
  let leading = element.text("L")
  let trailing = element.text("T")
  let sb = new(leading, trailing)

  let expected =
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "filled"),
        attribute.attribute("id", "test-id"),
      ],
      [leading, trailing],
    )

  render(sb, [attribute.attribute("id", "test-id")]) |> should.equal(expected)
}

pub fn split_button_leading_trailing_update_test() {
  let l1 = element.text("L1")
  let t1 = element.text("T1")
  let l2 = element.text("L2")
  let t2 = element.text("T2")

  new(l1, t1)
  |> split_button.leading(l2)
  |> split_button.trailing(t2)
  |> render([])
  |> should.equal(
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "filled"),
      ],
      [l2, t2],
    ),
  )
}

pub fn config_test() {
  let leading = element.text("L")
  let trailing = element.text("T")
  split_button.default_config(leading, trailing)
  |> should.equal(split_button.Config(
    leading: leading,
    size: config.Small,
    trailing: trailing,
    variant: split_button.Filled,
  ))
}

pub fn from_config_test() {
  let leading = element.text("L")
  let trailing = element.text("T")
  let config = split_button.default_config(leading, trailing)
  split_button.from_config(config)
  |> split_button.render([])
  |> should.equal(
    split_button.new(leading, trailing)
    |> split_button.render([]),
  )
}

pub fn render_config_test() {
  let leading = element.text("L")
  let trailing = element.text("T")
  let config = split_button.default_config(leading, trailing)
  split_button.render_config(config, [])
  |> should.equal(
    split_button.new(leading, trailing)
    |> split_button.render([]),
  )
}
