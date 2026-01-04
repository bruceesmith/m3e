import gleeunit/should
import lustre/attribute.{attribute, name}
import lustre/element.{element}
import m3e/icon

pub fn basic_test() {
  let basic_icon = icon.basic("home")

  basic_icon.name
  |> should.equal("home")

  basic_icon.filled
  |> should.be_false()

  basic_icon.grade
  |> should.equal(icon.default_grade)

  basic_icon.optical_size
  |> should.equal(icon.default_optical_size)

  basic_icon.purpose
  |> should.equal(icon.default_purpose)

  basic_icon.weight
  |> should.equal(icon.default_weight)
}

pub fn element_test() {
  let i =
    icon.basic("home")
    |> icon.filled(True)
    |> icon.grade(icon.High)
    |> icon.optical_size(40)
    |> icon.purpose(icon.Trailing)
    |> icon.variant(icon.Rounded)
    |> icon.weight(600)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "1"),
        attribute("grade", "high"),
        attribute("optical-size", "40"),
        attribute("slot", "trailing-icon"),
        attribute("variant", "rounded"),
        attribute("weight", "600"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)
}

pub fn filled_test() {
  let i =
    icon.basic("home")
    |> icon.filled(True)

  i.filled
  |> should.be_true()
}

pub fn filled_attr_test() {
  let i =
    icon.basic("home")
    |> icon.filled(True)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "1"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.filled(False)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)
}

pub fn grade_test() {
  let i =
    icon.basic("home")
    |> icon.grade(icon.Low)

  i.grade
  |> should.equal(icon.Low)
}

pub fn grade_attr_test() {
  let i =
    icon.basic("home")
    |> icon.grade(icon.Low)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "low"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.grade(icon.Medium)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.grade(icon.High)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "high"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)
}

pub fn leading_test() {
  let i = icon.basic("home")

  i
  |> icon.leading
  |> should.be_true()

  let i =
    i
    |> icon.purpose(icon.Trailing)

  i
  |> icon.leading
  |> should.be_false()
}

pub fn optical_size_test() {
  let i = icon.basic("home")

  // Valid cases
  let icon_os_20 = i |> icon.optical_size(20)
  icon_os_20.optical_size
  |> should.equal(20)

  let icon_os_30 = i |> icon.optical_size(30)
  icon_os_30.optical_size
  |> should.equal(30)

  let icon_os_48 = i |> icon.optical_size(48)
  icon_os_48.optical_size
  |> should.equal(48)

  // Invalid cases
  let icon_os_19 = i |> icon.optical_size(19)
  icon_os_19.optical_size
  |> should.equal(icon.default_optical_size)

  let icon_os_49 = i |> icon.optical_size(49)
  icon_os_49.optical_size
  |> should.equal(icon.default_optical_size)

  let icon_os_0 = i |> icon.optical_size(0)
  icon_os_0.optical_size
  |> should.equal(icon.default_optical_size)

  let icon_os_100 = i |> icon.optical_size(100)
  icon_os_100.optical_size
  |> should.equal(icon.default_optical_size)
}

pub fn optical_size_attr_test() {
  let i =
    icon.basic("home")
    |> icon.optical_size(36)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "36"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)
}

pub fn purpose_test() {
  let i =
    icon.basic("home")
    |> icon.purpose(icon.Selected)

  i.purpose
  |> should.equal(icon.Selected)
}

pub fn purpose_attr_test() {
  let i =
    icon.basic("home")
    |> icon.purpose(icon.Leading)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.purpose(icon.Selected)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "selected-icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.purpose(icon.Trailing)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "trailing-icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)
}

pub fn variant_test() {
  let i =
    icon.basic("home")
    |> icon.variant(icon.Sharp)

  i.variant
  |> should.equal(icon.Sharp)
}

pub fn variant_attr_test() {
  let i =
    icon.basic("home")
    |> icon.variant(icon.Outlined)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.variant(icon.Rounded)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "rounded"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.variant(icon.Sharp)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "sharp"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)
}

pub fn weight_test() {
  let i = icon.basic("home")

  // Valid cases
  let icon_w_100 = i |> icon.weight(100)
  icon_w_100.weight
  |> should.equal(100)

  let icon_w_400 = i |> icon.weight(400)
  icon_w_400.weight
  |> should.equal(400)

  let icon_w_700 = i |> icon.weight(700)
  icon_w_700.weight
  |> should.equal(700)

  // Invalid cases
  let icon_w_99 = i |> icon.weight(99)
  icon_w_99.weight
  |> should.equal(icon.default_weight)

  let icon_w_701 = i |> icon.weight(701)
  icon_w_701.weight
  |> should.equal(icon.default_weight)

  let icon_w_0 = i |> icon.weight(0)
  icon_w_0.weight
  |> should.equal(icon.default_weight)

  let icon_w_800 = i |> icon.weight(800)
  icon_w_800.weight
  |> should.equal(icon.default_weight)
}

pub fn weight_attr_test() {
  let i =
    icon.basic("home")
    |> icon.weight(600)

  let expected =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "600"),
      ],
      [],
    )

  icon.element(i, [], [])
  |> should.equal(expected)
}
