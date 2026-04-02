import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/state.{Disabled}
import m3e/toc_item

pub fn new_test() {
  toc_item.new()
  |> toc_item.render([], [])
  |> should.equal(element.element("m3e-toc-item", [attribute.none()], []))
}

pub fn disabled_test() {
  toc_item.new()
  |> toc_item.disabled(Disabled)
  |> toc_item.render([], [])
  |> should.equal(
    element.element("m3e-toc-item", [attribute.attribute("disabled", "")], []),
  )
}

pub fn attributes_test() {
  toc_item.new()
  |> toc_item.render([attribute.class("custom-item")], [])
  |> should.equal(
    element.element(
      "m3e-toc-item",
      [attribute.none(), attribute.class("custom-item")],
      [],
    ),
  )
}

pub fn children_test() {
  let child = element.text("Toc Content")
  toc_item.new()
  |> toc_item.render([], [child])
  |> should.equal(element.element("m3e-toc-item", [attribute.none()], [child]))
}
