import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import m3e/menu_trigger

pub fn basic_test() {
  let t = menu_trigger.new("my-menu")

  let expected = element("m3e-menu-trigger", [attribute.for("my-menu")], [])

  menu_trigger.render(t)
  |> should.equal(expected)
}

pub fn for_test() {
  let t =
    menu_trigger.new("my-menu")
    |> menu_trigger.for("other-menu")

  let expected = element("m3e-menu-trigger", [attribute.for("other-menu")], [])

  menu_trigger.render(t)
  |> should.equal(expected)
}
