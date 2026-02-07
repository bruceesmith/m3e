import gleeunit/should
import lustre/attribute.{attribute, none}
import lustre/element.{element}
import lustre/element/html.{div, text}
import m3e/drawer
import m3e/drawer_container.{end, new, render, start, toggle_end, toggle_start}

pub fn drawer_container_creation_test() {
  let start_d = drawer.empty()
  let end_d = drawer.empty()
  let main = div([], [text("Main")])

  let c = new() |> start(start_d) |> end(end_d)

  let expected =
    element("m3e-drawer-container", [], [
      element.none(),
      main,
      element.none(),
    ])

  render(c, [], [main]) |> should.equal(expected)
}

pub fn drawer_container_element_test() {
  let start_d =
    drawer.new()
    |> drawer.usage(drawer.Start)
    |> drawer.mode(drawer.Side)
    |> drawer.open(True)
    |> drawer.id("s")
    |> drawer.divider(True)
    |> drawer.content(text("S"))
  let end_d =
    drawer.new()
    |> drawer.usage(drawer.End)
    |> drawer.mode(drawer.Over)
    |> drawer.id("e")
    |> drawer.content(text("E"))
  let main = text("M")

  let c = new() |> start(start_d) |> end(end_d)

  let expected_attrs = [
    attribute("start", ""),
    attribute("start-divider", ""),
    attribute("start-mode", "side"),
    attribute("end-mode", "over"),
    attribute("class", "test"),
  ]

  let expected_children = [
    div([attribute("slot", "start"), attribute("id", "s")], [text("S")]),
    main,
    div([attribute("slot", "end"), attribute("id", "e")], [text("E")]),
  ]

  let expected =
    element("m3e-drawer-container", expected_attrs, expected_children)

  render(c, [attribute("class", "test")], [main]) |> should.equal(expected)
}

pub fn drawer_container_setters_test() {
  let main = text("main")
  let c = new()

  let start_d =
    drawer.new()
    |> drawer.usage(drawer.Start)
    |> drawer.mode(drawer.Auto)
    |> drawer.open(True)
    |> drawer.content(text("S"))
  let c2 = c |> start(start_d)

  let expected_start =
    element(
      "m3e-drawer-container",
      [
        attribute("start", ""),
        attribute("start-mode", "auto"),
      ],
      [
        div([attribute("slot", "start"), none()], [text("S")]),
        main,
        element.none(),
      ],
    )

  render(c2, [], [main]) |> should.equal(expected_start)

  let end_d =
    drawer.new()
    |> drawer.usage(drawer.End)
    |> drawer.mode(drawer.Push)
    |> drawer.open(True)
    |> drawer.divider(True)
    |> drawer.content(text("E"))
  let c3 = c2 |> end(end_d)

  let expected_full =
    element(
      "m3e-drawer-container",
      [
        attribute("start", ""),
        attribute("start-mode", "auto"),
        attribute("end", ""),
        attribute("end-divider", ""),
        attribute("end-mode", "push"),
      ],
      [
        div([attribute("slot", "start"), none()], [text("S")]),
        main,
        div([attribute("slot", "end"), none()], [text("E")]),
      ],
    )

  render(c3, [], [main]) |> should.equal(expected_full)
}

pub fn drawer_container_toggle_test() {
  let start_d =
    drawer.new()
    |> drawer.usage(drawer.Start)
    |> drawer.mode(drawer.Side)
    |> drawer.id("s")
    |> drawer.content(text("S"))
  let end_d =
    drawer.new()
    |> drawer.usage(drawer.End)
    |> drawer.mode(drawer.Side)
    |> drawer.id("e")
    |> drawer.content(text("E"))
  let main = text("M")

  let c = new() |> start(start_d) |> end(end_d)

  // Toggle Start -> Open
  let c2 = c |> toggle_start()

  let expected_start_open =
    element(
      "m3e-drawer-container",
      [
        attribute("start", ""),
        attribute("start-mode", "side"),
        attribute("end-mode", "side"),
      ],
      [
        div([attribute("slot", "start"), attribute("id", "s")], [text("S")]),
        main,
        div([attribute("slot", "end"), attribute("id", "e")], [text("E")]),
      ],
    )

  render(c2, [], [main]) |> should.equal(expected_start_open)

  // Toggle Start -> Closed
  let c3 = c2 |> toggle_start()

  let expected_closed =
    element(
      "m3e-drawer-container",
      [attribute("start-mode", "side"), attribute("end-mode", "side")],
      [
        div([attribute("slot", "start"), attribute("id", "s")], [text("S")]),
        main,
        div([attribute("slot", "end"), attribute("id", "e")], [text("E")]),
      ],
    )

  render(c3, [], [main]) |> should.equal(expected_closed)

  // Toggle End -> Open
  let c4 = c3 |> toggle_end()

  let expected_end_open =
    element(
      "m3e-drawer-container",
      [
        attribute("start-mode", "side"),
        attribute("end", ""),
        attribute("end-mode", "side"),
      ],
      [
        div([attribute("slot", "start"), attribute("id", "s")], [text("S")]),
        main,
        div([attribute("slot", "end"), attribute("id", "e")], [text("E")]),
      ],
    )

  render(c4, [], [main]) |> should.equal(expected_end_open)
}
