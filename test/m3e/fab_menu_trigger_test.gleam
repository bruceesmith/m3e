import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/fab_menu_trigger
import m3e/icon

pub fn basic_test() {
  let i = icon.new("add")
  let t = fab_menu_trigger.new("my-menu", i)

  let expected =
    element(
      "m3e-fab-menu-trigger",
      [attribute("for", "my-menu")],
      [icon.render(i, [], [])],
    )

  fab_menu_trigger.render(t, [], [])
  |> should.equal(expected)
}

pub fn for_test() {
  let i = icon.new("add")
  let t =
    fab_menu_trigger.new("my-menu", i)
    |> fab_menu_trigger.for_("other-menu")

  let expected =
    element(
      "m3e-fab-menu-trigger",
      [attribute("for", "other-menu")],
      [icon.render(i, [], [])],
    )

  fab_menu_trigger.render(t, [], [])
  |> should.equal(expected)
}

pub fn icon_test() {
  let i1 = icon.new("add")
  let i2 = icon.new("remove")
  let t =
    fab_menu_trigger.new("my-menu", i1)
    |> fab_menu_trigger.icon(i2)

  let expected =
    element(
      "m3e-fab-menu-trigger",
      [attribute("for", "my-menu")],
      [icon.render(i2, [], [])],
    )

  fab_menu_trigger.render(t, [], [])
  |> should.equal(expected)
}

pub fn children_test() {
  let i = icon.new("add")
  let t = fab_menu_trigger.new("my-menu", i)
  let child = element("span", [], [element.text("hello")])

  let expected =
    element(
      "m3e-fab-menu-trigger",
      [attribute("for", "my-menu")],
      [icon.render(i, [], []), child],
    )

  fab_menu_trigger.render(t, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let i = icon.new("add")
  let t = fab_menu_trigger.new("my-menu", i)
  let attr = attribute("class", "custom")

  let expected =
    element(
      "m3e-fab-menu-trigger",
      [attribute("for", "my-menu"), attr],
      [icon.render(i, [], [])],
    )

  fab_menu_trigger.render(t, [attr], [])
  |> should.equal(expected)
}
