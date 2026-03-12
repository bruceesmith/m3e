import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/drawer_container

// --- TESTS ---

pub fn render_default_test() {
  drawer_container.new()
  |> drawer_container.render()
  |> should.equal(element("m3e-drawer-container", [], []))
}

pub fn render_with_main_content_test() {
  let main = element("main", [], [])
  drawer_container.new()
  |> drawer_container.main_content(main)
  |> drawer_container.render()
  |> should.equal(element("m3e-drawer-container", [], [main]))
}

// --- Start Drawer Tests ---

pub fn start_drawer_test() {
  let start_drawer =
    element("div", [drawer_container.slot(drawer_container.Start)], [])

  drawer_container.new()
  |> drawer_container.start_drawer(Some(start_drawer))
  |> drawer_container.render()
  |> should.equal(
    element("m3e-drawer-container", [attribute("start-mode", "auto")], [
      start_drawer,
    ]),
  )
}

pub fn start_drawer_open_test() {
  let start_drawer =
    element("div", [drawer_container.slot(drawer_container.Start)], [])

  drawer_container.new()
  |> drawer_container.start_drawer(Some(start_drawer))
  |> drawer_container.start(True)
  |> drawer_container.render()
  |> should.equal(
    element(
      "m3e-drawer-container",
      [attribute("start", ""), attribute("start-mode", "auto")],
      [start_drawer],
    ),
  )
}

pub fn start_drawer_divider_test() {
  let start_drawer =
    element("div", [drawer_container.slot(drawer_container.Start)], [])

  drawer_container.new()
  |> drawer_container.start_drawer(Some(start_drawer))
  |> drawer_container.start_divider(True)
  |> drawer_container.render()
  |> should.equal(
    element(
      "m3e-drawer-container",
      [attribute("start-divider", ""), attribute("start-mode", "auto")],
      [start_drawer],
    ),
  )
}

pub fn start_drawer_mode_test() {
  let start_drawer =
    element("div", [drawer_container.slot(drawer_container.Start)], [])

  drawer_container.new()
  |> drawer_container.start_drawer(Some(start_drawer))
  |> drawer_container.start_mode(drawer_container.Push)
  |> drawer_container.render()
  |> should.equal(
    element("m3e-drawer-container", [attribute("start-mode", "push")], [
      start_drawer,
    ]),
  )
}

// --- End Drawer Tests ---

pub fn end_drawer_test() {
  let end_drawer =
    element("div", [drawer_container.slot(drawer_container.End)], [])

  drawer_container.new()
  |> drawer_container.end_drawer(Some(end_drawer))
  |> drawer_container.render()
  |> should.equal(
    element("m3e-drawer-container", [attribute("end-mode", "auto")], [
      end_drawer,
    ]),
  )
}

pub fn end_drawer_open_test() {
  let end_drawer =
    element("div", [drawer_container.slot(drawer_container.End)], [])

  drawer_container.new()
  |> drawer_container.end_drawer(Some(end_drawer))
  |> drawer_container.end(True)
  |> drawer_container.render()
  |> should.equal(
    element(
      "m3e-drawer-container",
      [attribute("end", ""), attribute("end-mode", "auto")],
      [end_drawer],
    ),
  )
}

pub fn end_drawer_divider_test() {
  let end_drawer =
    element("div", [drawer_container.slot(drawer_container.End)], [])

  drawer_container.new()
  |> drawer_container.end_drawer(Some(end_drawer))
  |> drawer_container.end_divider(True)
  |> drawer_container.render()
  |> should.equal(
    element(
      "m3e-drawer-container",
      [attribute("end-divider", ""), attribute("end-mode", "auto")],
      [end_drawer],
    ),
  )
}

pub fn end_drawer_mode_test() {
  let end_drawer =
    element("div", [drawer_container.slot(drawer_container.End)], [])

  drawer_container.new()
  |> drawer_container.end_drawer(Some(end_drawer))
  |> drawer_container.end_mode(drawer_container.Side)
  |> drawer_container.render()
  |> should.equal(
    element("m3e-drawer-container", [attribute("end-mode", "side")], [
      end_drawer,
    ]),
  )
}

// --- Combination and Edge Case Tests ---

pub fn all_content_and_options_test() {
  let start_drawer =
    element("div", [drawer_container.slot(drawer_container.Start)], [])
  let main = element("main", [], [])
  let end_drawer =
    element("div", [drawer_container.slot(drawer_container.End)], [])

  drawer_container.new()
  |> drawer_container.start_drawer(Some(start_drawer))
  |> drawer_container.start(True)
  |> drawer_container.start_divider(True)
  |> drawer_container.start_mode(drawer_container.Push)
  |> drawer_container.main_content(main)
  |> drawer_container.end_drawer(Some(end_drawer))
  |> drawer_container.end(True)
  |> drawer_container.end_divider(True)
  |> drawer_container.end_mode(drawer_container.Side)
  |> drawer_container.render()
  |> should.equal(
    element(
      "m3e-drawer-container",
      [
        attribute("end", ""),
        attribute("end-divider", ""),
        attribute("end-mode", "side"),
        attribute("start", ""),
        attribute("start-divider", ""),
        attribute("start-mode", "push"),
      ],
      [start_drawer, main, end_drawer],
    ),
  )
}

pub fn setters_have_no_effect_if_drawer_is_none_test() {
  let expected = element("m3e-drawer-container", [], [])

  drawer_container.new()
  |> drawer_container.start(True)
  |> drawer_container.start_divider(True)
  |> drawer_container.start_mode(drawer_container.Push)
  |> drawer_container.end(True)
  |> drawer_container.end_divider(True)
  |> drawer_container.end_mode(drawer_container.Push)
  |> drawer_container.render()
  |> should.equal(expected)
}

pub fn from_config_ignores_fields_if_drawer_is_none_test() {
  let config =
    drawer_container.default_config()
    |> fn(c) {
      drawer_container.Config(
        ..c,
        start: True,
        start_divider: True,
        start_mode: drawer_container.Push,
        start_drawer: None,
      )
    }

  drawer_container.from_config(config)
  |> drawer_container.render()
  |> should.equal(element("m3e-drawer-container", [], []))
}

pub fn render_config_test() {
  let start_drawer =
    element("div", [drawer_container.slot(drawer_container.Start)], [])
  let main = element("main", [], [])
  let end_drawer =
    element("div", [drawer_container.slot(drawer_container.End)], [])

  let config =
    drawer_container.default_config()
    |> fn(c) {
      drawer_container.Config(
        ..c,
        start: True,
        start_drawer: Some(start_drawer),
        start_mode: drawer_container.Push,
        main_content: main,
        end_drawer: Some(end_drawer),
        end_divider: True,
      )
    }

  let expected =
    element(
      "m3e-drawer-container",
      [
        attribute("end-divider", ""),
        attribute("end-mode", "auto"),
        attribute("start", ""),
        attribute("start-mode", "push"),
      ],
      [start_drawer, main, end_drawer],
    )

  drawer_container.render_config(config)
  |> should.equal(expected)
}

pub fn slot_function_test() {
  drawer_container.slot(drawer_container.Start)
  |> should.equal(attribute("slot", "start"))

  drawer_container.slot(drawer_container.End)
  |> should.equal(attribute("slot", "end"))
}
