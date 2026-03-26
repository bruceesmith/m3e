import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/accordion

pub fn accordion_test() {
  let a = accordion.new() |> accordion.multi(True)
  let expected =
    element.element("m3e-accordion", [attribute.attribute("multi", "")], [])
  accordion.render(a, [], []) |> should.equal(expected)
}

pub fn defaults_test() {
  let a = accordion.new()
  let expected = element.element("m3e-accordion", [], [])
  accordion.render(a, [], []) |> should.equal(expected)
}
