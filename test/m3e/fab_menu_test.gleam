import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/fab_menu

pub fn basic_test() {
  let m = fab_menu.new("my-menu")

  let expected =
    element(
      "m3e-fab-menu",
      [
        attribute("id", "my-menu"),
        attribute("variant", "primary"),
      ],
      [],
    )

  fab_menu.render(m, [], [])
  |> should.equal(expected)
}

pub fn id_test() {
  let m =
    fab_menu.new("my-menu")
    |> fab_menu.id("other-menu")

  let expected =
    element(
      "m3e-fab-menu",
      [
        attribute("id", "other-menu"),
        attribute("variant", "primary"),
      ],
      [],
    )

  fab_menu.render(m, [], [])
  |> should.equal(expected)
}

pub fn variant_test() {
  let m =
    fab_menu.new("my-menu")
    |> fab_menu.variant(fab_menu.Secondary)

  let expected =
    element(
      "m3e-fab-menu",
      [
        attribute("id", "my-menu"),
        attribute("variant", "secondary"),
      ],
      [],
    )

  fab_menu.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    fab_menu.new("my-menu")
    |> fab_menu.variant(fab_menu.Tertiary)

  let expected2 =
    element(
      "m3e-fab-menu",
      [
        attribute("id", "my-menu"),
        attribute("variant", "tertiary"),
      ],
      [],
    )

  fab_menu.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let m = fab_menu.new("my-menu")
  let child = element("div", [], [])

  let expected =
    element(
      "m3e-fab-menu",
      [
        attribute("id", "my-menu"),
        attribute("variant", "primary"),
      ],
      [child],
    )

  fab_menu.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = fab_menu.new("my-menu")
  let attr = attribute("class", "custom")

  let expected =
    element(
      "m3e-fab-menu",
      [
        attribute("id", "my-menu"),
        attribute("variant", "primary"),
        attr,
      ],
      [],
    )

  fab_menu.render(m, [attr], [])
  |> should.equal(expected)
}
