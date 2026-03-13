import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/list
import m3e/list_variant

pub fn default_config_test() {
  list.default_config()
  |> should.equal(list.Config(variant: list_variant.Standard))
}

pub fn new_test() {
  list.new()
  |> list.render([], [])
  |> should.equal(
    element.element(
      "m3e-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

pub fn from_config_test() {
  list.from_config(list.default_config())
  |> list.render([], [])
  |> should.equal(
    element.element(
      "m3e-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

pub fn render_config_test() {
  list.render_config(list.default_config(), [], [])
  |> should.equal(
    element.element(
      "m3e-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

pub fn variant_test() {
  list.new()
  |> list.variant(list_variant.Segmented)
  |> list.render([], [])
  |> should.equal(
    element.element(
      "m3e-list",
      [attribute.attribute("variant", "segmented")],
      [],
    ),
  )
}

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  list.new()
  |> list.render(attrs, children)
  |> should.equal(element.element(
    "m3e-list",
    [
      attribute.attribute("variant", "standard"),
      attribute.class("custom-class"),
    ],
    children,
  ))
}
