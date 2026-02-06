import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/app_bar

pub fn new_test() {
  app_bar.new(True, Some("nav-id"), app_bar.Large)
  |> should.equal(app_bar.AppBar(
    centered: True,
    for: Some("nav-id"),
    size: app_bar.Large,
  ))
}

pub fn render_test() {
  let bar = app_bar.new(True, Some("nav-id"), app_bar.Large)

  app_bar.render(bar, [])
  |> should.equal(
    element.element(
      "m3e-app-bar",
      [
        attribute.attribute("centered", ""),
        attribute.attribute("size", "large"),
        attribute.attribute("for", "nav-id"),
      ],
      [],
    ),
  )
}

pub fn render_defaults_test() {
  let bar = app_bar.new(False, None, app_bar.Small)

  app_bar.render(bar, [element.text("Title")])
  |> should.equal(
    element.element("m3e-app-bar", [attribute.attribute("size", "small")], [
      element.text("Title"),
    ]),
  )
}
