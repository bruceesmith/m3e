import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/search_view

pub fn default_config_test() {
  let config = search_view.default_config()
  config.contained |> should.equal(search_view.Free)
  config.mode |> should.equal(search_view.Docked)
  config.open |> should.equal(search_view.Collapsed)
  config.clear_label |> should.equal(search_view.default_clear_label)
  config.close_label |> should.equal(search_view.default_close_label)
  config.hide_search_icon |> should.equal(search_view.Visible)
}

pub fn new_test() {
  let view = search_view.new()
  search_view.render(view, [], [])
  |> should.equal(
    element.element(
      "m3e-search-view",
      [attribute.attribute("mode", "docked")],
      [],
    ),
  )
}

pub fn from_config_test() {
  let config =
    search_view.Config(
      ..search_view.default_config(),
      contained: search_view.Contained,
      open: search_view.Expanded,
      hide_search_icon: search_view.Hidden,
    )
  let view = search_view.from_config(config)

  search_view.render(view, [], [])
  |> should.equal(
    element.element(
      "m3e-search-view",
      [
        attribute.attribute("contained", ""),
        attribute.attribute("mode", "docked"),
        attribute.attribute("open", ""),
        attribute.attribute("hide-search-icon", ""),
      ],
      [],
    ),
  )
}

pub fn setters_test() {
  search_view.new()
  |> search_view.contained(search_view.Contained)
  |> search_view.mode(search_view.Fullscreen)
  |> search_view.open(search_view.Expanded)
  |> search_view.clear_label("C")
  |> search_view.close_label("X")
  |> search_view.hide_search_icon(search_view.Hidden)
  |> search_view.render([], [])
  |> should.equal(
    element.element(
      "m3e-search-view",
      [
        attribute.attribute("contained", ""),
        attribute.attribute("mode", "fullscreen"),
        attribute.attribute("open", ""),
        attribute.attribute("clear-label", "C"),
        attribute.attribute("close-label", "X"),
        attribute.attribute("hide-search-icon", ""),
      ],
      [],
    ),
  )
}

pub fn render_config_test() {
  let config = search_view.default_config()
  search_view.render_config(config, [attribute.class("custom")], [])
  |> should.equal(
    element.element(
      "m3e-search-view",
      [attribute.attribute("mode", "docked"), attribute.class("custom")],
      [],
    ),
  )
}

pub fn slot_test() {
  search_view.slot(search_view.Input)
  |> should.equal(attribute.attribute("slot", "input"))

  search_view.slot(search_view.OpenLeading)
  |> should.equal(attribute.attribute("slot", "open-leading"))

  search_view.slot(search_view.OpenTrailing)
  |> should.equal(attribute.attribute("slot", "open-trailing"))

  search_view.slot(search_view.ClosedLeading)
  |> should.equal(attribute.attribute("slot", "closed-leading"))

  search_view.slot(search_view.ClosedTrailing)
  |> should.equal(attribute.attribute("slot", "closed-trailing"))
}
