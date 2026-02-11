import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/menu

pub fn basic_test() {
  let m = menu.new()

  let expected =
    element(
      "m3e-menu",
      [
        attribute("position-x", "after"),
        attribute("position-y", "below"),
        attribute("variant", "standard"),
      ],
      [],
    )

  menu.render(m, [], [])
  |> should.equal(expected)
}

pub fn position_x_test() {
  let m =
    menu.new()
    |> menu_with_x(menu.Before)

  let expected =
    element(
      "m3e-menu",
      [
        attribute("position-x", "before"),
        attribute("position-y", "below"),
        attribute("variant", "standard"),
      ],
      [],
    )

  menu.render(m, [], [])
  |> should.equal(expected)
}

fn menu_with_x(m: menu.Menu, x: menu.PositionX) -> menu.Menu {
  menu.position_x(m, x)
}

pub fn position_y_test() {
  let m =
    menu.new()
    |> menu_with_y(menu.Above)

  let expected =
    element(
      "m3e-menu",
      [
        attribute("position-x", "after"),
        attribute("position-y", "above"),
        attribute("variant", "standard"),
      ],
      [],
    )

  menu.render(m, [], [])
  |> should.equal(expected)
}

fn menu_with_y(m: menu.Menu, y: menu.PositionY) -> menu.Menu {
  menu.position_y(m, y)
}

pub fn variant_test() {
  let m =
    menu.new()
    |> menu_with_variant(menu.Vibrant)

  let expected =
    element(
      "m3e-menu",
      [
        attribute("position-x", "after"),
        attribute("position-y", "below"),
        attribute("variant", "vibrant"),
      ],
      [],
    )

  menu.render(m, [], [])
  |> should.equal(expected)
}

fn menu_with_variant(m: menu.Menu, v: menu.Variant) -> menu.Menu {
  menu.variant(m, v)
}

pub fn children_test() {
  let m = menu.new()
  let child = element("span", [], [])

  let expected =
    element(
      "m3e-menu",
      [
        attribute("position-x", "after"),
        attribute("position-y", "below"),
        attribute("variant", "standard"),
      ],
      [child],
    )

  menu.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = menu.new()
  let attr = attribute("class", "custom")

  let expected =
    element(
      "m3e-menu",
      [
        attribute("position-x", "after"),
        attribute("position-y", "below"),
        attribute("variant", "standard"),
        attr,
      ],
      [],
    )

  menu.render(m, [attr], [])
  |> should.equal(expected)
}
