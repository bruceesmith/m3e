import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/config
import m3e/split_button.{Elevated, Outlined, Tonal}

pub fn split_button_new_test() {
  let leading = element.text("Leading")
  let trailing = element.text("Trailing")
  let sb = split_button.new(leading, trailing)

  let expected =
    element.element(
      "m3e-split-button",
      [
        attribute.attribute("size", "small"),
        attribute.attribute("variant", "filled"),
      ],
      [leading, trailing],
    )

  split_button.render(sb, []) |> should.equal(expected)
}

pub fn split_button_size_test() {
  let leading = element.text("L")
  let trailing = element.text("T")

  split_button.new(leading, trailing)
  |> split_button.size(config.ExtraLarge)
  |> split_button.render([])
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

  split_button.new(leading, trailing)
  |> split_button.size(config.Large)
  |> split_button.render([])
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

  split_button.new(leading, trailing)
  |> split_button.variant(Elevated)
  |> split_button.render([])
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

  split_button.new(leading, trailing)
  |> split_button.variant(Outlined)
  |> split_button.render([])
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

  split_button.new(leading, trailing)
  |> split_button.variant(Tonal)
  |> split_button.render([])
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
  let sb = split_button.new(leading, trailing)

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

  split_button.render(sb, [attribute.attribute("id", "test-id")])
  |> should.equal(expected)
}

pub fn split_button_leading_trailing_update_test() {
  let l1 = element.text("L1")
  let t1 = element.text("T1")
  let l2 = element.text("L2")
  let t2 = element.text("T2")

  split_button.new(l1, t1)
  |> split_button.leading(l2)
  |> split_button.trailing(t2)
  |> split_button.render([])
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
