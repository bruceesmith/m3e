import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/fab_menu

pub fn basic_test() {
  let m = fab_menu.new("my-menu")

  let expected =
    element.element(
      "m3e-fab-menu",
      [
        attribute.attribute("id", "my-menu"),
        attribute.attribute("variant", "primary"),
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
    element.element(
      "m3e-fab-menu",
      [
        attribute.attribute("id", "other-menu"),
        attribute.attribute("variant", "primary"),
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
    element.element(
      "m3e-fab-menu",
      [
        attribute.attribute("id", "my-menu"),
        attribute.attribute("variant", "secondary"),
      ],
      [],
    )

  fab_menu.render(m, [], [])
  |> should.equal(expected)

  let m2 =
    fab_menu.new("my-menu")
    |> fab_menu.variant(fab_menu.Tertiary)

  let expected2 =
    element.element(
      "m3e-fab-menu",
      [
        attribute.attribute("id", "my-menu"),
        attribute.attribute("variant", "tertiary"),
      ],
      [],
    )

  fab_menu.render(m2, [], [])
  |> should.equal(expected2)
}

pub fn children_test() {
  let m = fab_menu.new("my-menu")
  let child = element.element("div", [], [])

  let expected =
    element.element(
      "m3e-fab-menu",
      [
        attribute.attribute("id", "my-menu"),
        attribute.attribute("variant", "primary"),
      ],
      [child],
    )

  fab_menu.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = fab_menu.new("my-menu")
  let attr = attribute.attribute("class", "custom")

  let expected =
    element.element(
      "m3e-fab-menu",
      [
        attribute.attribute("id", "my-menu"),
        attribute.attribute("variant", "primary"),
        attr,
      ],
      [],
    )

  fab_menu.render(m, [attr], [])
  |> should.equal(expected)
}
