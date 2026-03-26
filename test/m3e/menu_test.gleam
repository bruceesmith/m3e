import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/menu
import m3e/state.{Disabled, Enabled}

pub fn basic_test() {
  let m = menu.new()

  let expected =
    element.element(
      "m3e-menu",
      [
        attribute.attribute("position-x", "after"),
        attribute.attribute("position-y", "below"),
        attribute.attribute("variant", "standard"),
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
    element.element(
      "m3e-menu",
      [
        attribute.attribute("position-x", "before"),
        attribute.attribute("position-y", "below"),
        attribute.attribute("variant", "standard"),
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
    element.element(
      "m3e-menu",
      [
        attribute.attribute("position-x", "after"),
        attribute.attribute("position-y", "above"),
        attribute.attribute("variant", "standard"),
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
    element.element(
      "m3e-menu",
      [
        attribute.attribute("position-x", "after"),
        attribute.attribute("position-y", "below"),
        attribute.attribute("variant", "vibrant"),
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
  let child = element.element("span", [], [])

  let expected =
    element.element(
      "m3e-menu",
      [
        attribute.attribute("position-x", "after"),
        attribute.attribute("position-y", "below"),
        attribute.attribute("variant", "standard"),
      ],
      [child],
    )

  menu.render(m, [], [child])
  |> should.equal(expected)
}

pub fn attributes_test() {
  let m = menu.new()
  let attr = attribute.attribute("class", "custom")

  let expected =
    element.element(
      "m3e-menu",
      [
        attribute.attribute("position-x", "after"),
        attribute.attribute("position-y", "below"),
        attribute.attribute("variant", "standard"),
        attr,
      ],
      [],
    )

  menu.render(m, [attr], [])
  |> should.equal(expected)
}

pub fn config_test() {
  let c =
    menu.default_config()
    |> fn(c) {
      menu.Config(
        ..c,
        anchor: Some("my-anchor"),
        interaction: Disabled,
        state: menu.Open,
        quick: menu.Instant,
      )
    }

  let m = menu.from_config(c)

  let expected =
    element.element(
      "m3e-menu",
      [
        attribute.attribute("anchor", "my-anchor"),
        attribute.attribute("disabled", ""),
        attribute.attribute("open", ""),
        attribute.attribute("position-x", "after"),
        attribute.attribute("position-y", "below"),
        attribute.attribute("quick", ""),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )

  menu.render(m, [], [])
  |> should.equal(expected)
}

pub fn default_config_test() {
  let c = menu.default_config()

  c.anchor |> should.equal(None)
  c.interaction |> should.equal(Enabled)
  c.position_x |> should.equal(menu.After)
  c.position_y |> should.equal(menu.Below)
  c.quick |> should.equal(menu.Animated)
  c.state |> should.equal(menu.Closed)
  c.variant |> should.equal(menu.Standard)
}

pub fn from_config_test() {
  let c = menu.default_config()
  let m = menu.from_config(c)

  menu.render(m, [], [])
  |> should.equal(menu.render(menu.new(), [], []))
}

pub fn render_config_test() {
  let c = menu.default_config()
  let expected = menu.render(menu.from_config(c), [], [])

  menu.render_config(c, [], [])
  |> should.equal(expected)
}

pub fn setters_test() {
  let m =
    menu.new()
    |> menu.anchor("my-anchor")
    |> menu.disabled(Disabled)
    |> menu.open(menu.Open)
    |> menu.quick(menu.Instant)

  let expected =
    element.element(
      "m3e-menu",
      [
        attribute.attribute("anchor", "my-anchor"),
        attribute.attribute("disabled", ""),
        attribute.attribute("open", ""),
        attribute.attribute("position-x", "after"),
        attribute.attribute("position-y", "below"),
        attribute.attribute("quick", ""),
        attribute.attribute("variant", "standard"),
      ],
      [],
    )

  menu.render(m, [], [])
  |> should.equal(expected)
}
