import gleam/option.{Some}
import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/app_bar
import m3e/config

pub fn new_test() {
  app_bar.new()
  |> app_bar.alignment(app_bar.Centered)
  |> app_bar.for(Some("nav-id"))
  |> app_bar.size(config.Large)
  |> should.equal(
    app_bar.from_config(app_bar.Config(
      alignment: app_bar.Centered,
      for: Some("nav-id"),
      size: config.Large,
    )),
  )
}

pub fn alignment_test() {
  app_bar.new()
  |> app_bar.alignment(app_bar.Centered)
  |> should.equal(app_bar.from_config(
    app_bar.Config(..app_bar.default_config(), alignment: app_bar.Centered),
  ))
}

pub fn for_test() {
  app_bar.new()
  |> app_bar.for(Some("test-id"))
  |> should.equal(app_bar.from_config(
    app_bar.Config(..app_bar.default_config(), for: Some("test-id")),
  ))
}

pub fn size_test() {
  app_bar.new()
  |> app_bar.size(config.Large)
  |> should.equal(app_bar.from_config(
    app_bar.Config(..app_bar.default_config(), size: config.Large),
  ))
}

pub fn render_test() {
  let bar =
    app_bar.new()
    |> app_bar.alignment(app_bar.Centered)
    |> app_bar.for(Some("nav-id"))
    |> app_bar.size(config.Large)

  app_bar.render(bar, [], [])
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
  let bar = app_bar.new()

  app_bar.render(bar, [], [element.text("Title")])
  |> should.equal(
    element.element("m3e-app-bar", [attribute.attribute("size", "small")], [
      element.text("Title"),
    ]),
  )
}
