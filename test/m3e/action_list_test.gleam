import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/action_list
import m3e/list_variant

pub fn new_test() {
  action_list.new(list_variant.Standard)
  |> action_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-action-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

pub fn variant_test() {
  action_list.new(list_variant.Standard)
  |> action_list.variant(list_variant.Standard)
  |> action_list.render([], [])
  |> should.equal(
    element.element(
      "m3e-action-list",
      [attribute.attribute("variant", "standard")],
      [],
    ),
  )
}

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  action_list.new(list_variant.Standard)
  |> action_list.render(attrs, children)
  |> should.equal(element.element(
    "m3e-action-list",
    [
      attribute.attribute("variant", "standard"),
      attribute.class("custom-class"),
    ],
    children,
  ))
}
