import gleeunit
import gleeunit/should
import lustre/attribute
import lustre/element.{element}
import m3e/nav_bar

pub fn main() {
  gleeunit.main()
}

pub fn basic_render_test() {
  nav_bar.new()
  |> nav_bar.render([], [])
  |> should.equal(
    element("m3e-nav-bar", [attribute.attribute("mode", "compact")], []),
  )
}

pub fn mode_test() {
  nav_bar.new()
  |> nav_bar.mode(nav_bar.Auto)
  |> nav_bar.render([], [])
  |> should.equal(
    element("m3e-nav-bar", [attribute.attribute("mode", "auto")], []),
  )

  nav_bar.new()
  |> nav_bar.mode(nav_bar.Expanded)
  |> nav_bar.render([], [])
  |> should.equal(
    element("m3e-nav-bar", [attribute.attribute("mode", "expanded")], []),
  )
}
