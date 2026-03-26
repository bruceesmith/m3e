import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/nav_menu

pub fn basic_render_test() {
  let content = [html.text("Menu Content")]
  let id = "test-nav-menu"

  nav_menu.new()
  |> nav_menu.render([attribute.id(id)], content)
  |> should.equal(element.element("m3e-nav-menu", [attribute.id(id)], content))
}
