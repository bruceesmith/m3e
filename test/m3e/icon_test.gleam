import gleeunit/should
import lustre/attribute.{attribute, name}
import lustre/element.{element}
import m3e/icon

pub fn basic_test() {
  let basic_icon = icon.basic("home")

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
  icon.render(basic_icon, [], []) |> should.equal(expected)
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
        attribute("slot", "trailing"),
        attribute("variant", "rounded"),
        attribute("weight", "600"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn filled_test() {
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
  icon.render(i, [], []) |> should.equal(expected)
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

  icon.render(i, [], [])
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

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn grade_test() {
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
  icon.render(i, [], []) |> should.equal(expected)
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

  icon.render(i, [], [])
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

  icon.render(i, [], [])
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

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn leading_test() {
  let i =
    icon.basic("home")
    |> icon.purpose(icon.Leading)

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
  let expected_20 =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "20"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )
  icon.render(icon_os_20, [], []) |> should.equal(expected_20)

  let icon_os_30 = i |> icon.optical_size(30)
  let expected_30 =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "30"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )
  icon.render(icon_os_30, [], []) |> should.equal(expected_30)

  let icon_os_48 = i |> icon.optical_size(48)
  let expected_48 =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "48"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )
  icon.render(icon_os_48, [], []) |> should.equal(expected_48)

  // Invalid cases
  let expected_default =
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

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn purpose_test() {
  let i =
    icon.basic("home")
    |> icon.purpose(icon.SelectedIcon)

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
  icon.render(i, [], []) |> should.equal(expected)
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
        attribute("slot", "leading"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)

  let i =
    icon.basic("home")
    |> icon.purpose(icon.SelectedIcon)

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

  icon.render(i, [], [])
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
        attribute("slot", "trailing"),
        attribute("variant", "outlined"),
        attribute("weight", "400"),
      ],
      [],
    )

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn variant_test() {
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
  icon.render(i, [], []) |> should.equal(expected)
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

  icon.render(i, [], [])
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

  icon.render(i, [], [])
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

  icon.render(i, [], [])
  |> should.equal(expected)
}

pub fn weight_test() {
  let i = icon.basic("home")

  // Valid cases
  let icon_w_100 = i |> icon.weight(100)
  let expected_100 =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "100"),
      ],
      [],
    )
  icon.render(icon_w_100, [], []) |> should.equal(expected_100)

  let icon_w_400 = i |> icon.weight(400)
  let expected_400 =
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
  icon.render(icon_w_400, [], []) |> should.equal(expected_400)

  let icon_w_700 = i |> icon.weight(700)
  let expected_700 =
    element(
      "m3e-icon",
      [
        name("home"),
        attribute("filled", "0"),
        attribute("grade", "medium"),
        attribute("optical-size", "24"),
        attribute("slot", "icon"),
        attribute("variant", "outlined"),
        attribute("weight", "700"),
      ],
      [],
    )
  icon.render(icon_w_700, [], []) |> should.equal(expected_700)

  // Invalid cases
  let expected_default =
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

  icon.render(i, [], [])
  |> should.equal(expected)
}
