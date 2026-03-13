import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/list_item

pub fn render_test() {
  let children = [element.text("some content")]
  list_item.render(children)
  |> should.equal(element.element("m3e-list-item", [], children))
}

pub fn slot_test() {
  list_item.slot(list_item.Leading)
  |> should.equal(attribute.attribute("slot", "leading"))

  list_item.slot(list_item.Overline)
  |> should.equal(attribute.attribute("slot", "overline"))

  list_item.slot(list_item.SupportingText)
  |> should.equal(attribute.attribute("slot", "supporting-text"))

  list_item.slot(list_item.Trailing)
  |> should.equal(attribute.attribute("slot", "trailing"))
}
