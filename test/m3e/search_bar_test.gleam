import gleeunit/should

import lustre/attribute
import lustre/element

import m3e/search_bar

pub fn default_config_test() {
  let config = search_bar.default_config()
  config.clearable |> should.equal(search_bar.NotClearable)
  config.clear_label |> should.equal(search_bar.default_clear_label)
}

pub fn new_test() {
  let sb = search_bar.new()
  search_bar.render(sb, [], [])
  |> should.equal(element.element("m3e-search-bar", [], []))
}

pub fn from_config_test() {
  let config =
    search_bar.Config(
      ..search_bar.default_config(),
      clearable: search_bar.Clearable,
    )
  let sb = search_bar.from_config(config)

  search_bar.render(sb, [], [])
  |> should.equal(
    element.element(
      "m3e-search-bar",
      [attribute.attribute("clearable", "")],
      [],
    ),
  )
}

pub fn setters_test() {
  search_bar.new()
  |> search_bar.clearable(search_bar.Clearable)
  |> search_bar.clear_label("X")
  |> search_bar.render([], [])
  |> should.equal(
    element.element(
      "m3e-search-bar",
      [
        attribute.attribute("clearable", ""),
        attribute.attribute("clear-label", "X"),
      ],
      [],
    ),
  )
}

pub fn render_config_test() {
  let config = search_bar.default_config()
  search_bar.render_config(config, [attribute.class("custom")], [])
  |> should.equal(
    element.element("m3e-search-bar", [attribute.class("custom")], []),
  )
}

pub fn slot_test() {
  search_bar.slot(search_bar.Leading)
  |> should.equal(attribute.attribute("slot", "leading"))

  search_bar.slot(search_bar.Input)
  |> should.equal(attribute.attribute("slot", "input"))

  search_bar.slot(search_bar.Trailing)
  |> should.equal(attribute.attribute("slot", "trailing"))
}
