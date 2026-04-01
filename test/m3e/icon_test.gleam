import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/button
import m3e/icon.{Config, Filled, High, Low, Medium, NotFilled, Rounded, Sharp}

pub fn basic_test() {
  let basic_icon = icon.new("home")

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(basic_icon, [], []) |> should.equal(expected)
}

pub fn element_test() {
  let i =
    icon.new("home")
    |> icon.filled(Filled)
    |> icon.grade(High)
    |> icon.optical_size(40)
    |> icon.purpose(button.slot(button.TrailingIcon))
    |> icon.variant(Rounded)
    |> icon.weight(600)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("filled", "1"),
        attribute.attribute("grade", "high"),
        attribute.attribute("optical-size", "40"),
        attribute.attribute("slot", "trailing-icon"),
        attribute.attribute("variant", "rounded"),
        attribute.attribute("weight", "600"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn filled_test() {
  let i =
    icon.new("home")
    |> icon.filled(Filled)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("filled", "1"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(i, [], []) |> should.equal(expected)
}

pub fn filled_attr_test() {
  let i =
    icon.new("home")
    |> icon.filled(Filled)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("filled", "1"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)

  let i =
    icon.new("home")
    |> icon.filled(NotFilled)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn grade_test() {
  let i =
    icon.new("home")
    |> icon.grade(Low)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "low"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(i, [], []) |> should.equal(expected)
}

pub fn grade_attr_test() {
  let i =
    icon.new("home")
    |> icon.grade(Low)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "low"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)

  let i =
    icon.new("home")
    |> icon.grade(Medium)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)

  let i =
    icon.new("home")
    |> icon.grade(High)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "high"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn optical_size_test() {
  let i = icon.new("home")

  // Valid cases
  let icon_os_20 = i |> icon.optical_size(20)
  let expected_20 =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "20"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(icon_os_20, [], []) |> should.equal(expected_20)

  let icon_os_30 = i |> icon.optical_size(30)
  let expected_30 =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "30"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(icon_os_30, [], []) |> should.equal(expected_30)

  let icon_os_48 = i |> icon.optical_size(48)
  let expected_48 =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "48"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(icon_os_48, [], []) |> should.equal(expected_48)

  // Invalid cases
  let expected_default =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  let icon_os_19 = i |> icon.optical_size(19)
  icon.render(icon_os_19, [], []) |> should.equal(expected_default)

  let icon_os_49 = i |> icon.optical_size(49)
  icon.render(icon_os_49, [], []) |> should.equal(expected_default)

  let icon_os_0 = i |> icon.optical_size(0)
  icon.render(icon_os_0, [], []) |> should.equal(expected_default)

  let icon_os_100 = i |> icon.optical_size(100)
  icon.render(icon_os_100, [], []) |> should.equal(expected_default)
}

pub fn optical_size_attr_test() {
  let i =
    icon.new("home")
    |> icon.optical_size(36)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "36"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn purpose_test() {
  let i =
    icon.new("home")
    |> icon.purpose(button.slot(button.SelectedIcon))

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("slot", "selected-icon"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(i, [], []) |> should.equal(expected)
}

pub fn purpose_attr_test() {
  let i =
    icon.new("home")
    |> icon.purpose(button.slot(button.SelectedIcon))

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("slot", "selected-icon"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)

  let i =
    icon.new("home")
    |> icon.purpose(button.slot(button.TrailingIcon))

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("slot", "trailing-icon"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn variant_test() {
  let i =
    icon.new("home")
    |> icon.variant(icon.Sharp)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "sharp"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(i, [], []) |> should.equal(expected)
}

pub fn variant_attr_test() {
  let i =
    icon.new("home")
    |> icon.variant(icon.Outlined)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)

  let i =
    icon.new("home")
    |> icon.variant(icon.Rounded)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "rounded"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)

  let i =
    icon.new("home")
    |> icon.variant(icon.Sharp)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "sharp"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn weight_test() {
  let i = icon.new("home")

  // Valid cases
  let icon_w_100 = i |> icon.weight(100)
  let expected_100 =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "100"),
      ],
      [],
    )
  icon.render(icon_w_100, [], []) |> should.equal(expected_100)

  let icon_w_400 = i |> icon.weight(400)
  let expected_400 =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )
  icon.render(icon_w_400, [], []) |> should.equal(expected_400)

  let icon_w_700 = i |> icon.weight(700)
  let expected_700 =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "700"),
      ],
      [],
    )
  icon.render(icon_w_700, [], []) |> should.equal(expected_700)

  // Invalid cases
  let expected_default =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "400"),
      ],
      [],
    )

  let icon_w_99 = i |> icon.weight(99)
  icon.render(icon_w_99, [], []) |> should.equal(expected_default)

  let icon_w_701 = i |> icon.weight(701)
  icon.render(icon_w_701, [], []) |> should.equal(expected_default)

  let icon_w_0 = i |> icon.weight(0)
  icon.render(icon_w_0, [], []) |> should.equal(expected_default)

  let icon_w_800 = i |> icon.weight(800)
  icon.render(icon_w_800, [], []) |> should.equal(expected_default)
}

pub fn weight_attr_test() {
  let i =
    icon.new("home")
    |> icon.weight(600)

  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("home"),
        attribute.attribute("grade", "medium"),
        attribute.attribute("optical-size", "24"),
        attribute.attribute("variant", "outlined"),
        attribute.attribute("weight", "600"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn render_config_test() {
  let config =
    Config(
      ..icon.default_config(),
      name: "settings",
      filled: Filled,
      grade: High,
      optical_size: 40,
      variant: Sharp,
      weight: 700,
    )
  let expected =
    element.element(
      "m3e-icon",
      [
        attribute.name("settings"),
        attribute.attribute("filled", "1"),
        attribute.attribute("grade", "high"),
        attribute.attribute("optical-size", "40"),
        attribute.attribute("variant", "sharp"),
        attribute.attribute("weight", "700"),
      ],
      [],
    )

  icon.render_config(config, [], [])
  |> should.equal(expected)
}
