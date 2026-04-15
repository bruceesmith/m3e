import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/split_panel.{Auto, Config, End, Horizontal, Start, Vertical}

pub fn split_panel_creation_test() {
  let sp = split_panel.new()
  let expected_basic = element.element("m3e-split-panel", [], [])
  split_panel.render(sp, [], []) |> should.equal(expected_basic)

  let sp_full =
    split_panel.new()
    |> split_panel.detents([25, 50, 75])
    |> split_panel.label("Custom Label")
    |> split_panel.max(90)
    |> split_panel.min(10)
    |> split_panel.orientation(Vertical)
    |> split_panel.step(5)
    |> split_panel.value(30)
    |> split_panel.wrap_detents(True)

  let expected_full =
    element.element(
      "m3e-split-panel",
      [
        attribute.attribute("detents", "25 50 75"),
        attribute.attribute("label", "Custom Label"),
        attribute.attribute("max", "90"),
        attribute.attribute("min", "10"),
        attribute.attribute("orientation", "vertical"),
        attribute.attribute("step", "5"),
        attribute.attribute("value", "30"),
        attribute.attribute("wrap-detents", ""),
      ],
      [],
    )
  split_panel.render(sp_full, [], []) |> should.equal(expected_full)
}

pub fn split_panel_element_test() {
  let sp = split_panel.new()
  let expected = element.element("m3e-split-panel", [], [])
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn config_test() {
  let config =
    Config(
      detents: [20, 80],
      label: "Config Label",
      max: 85,
      min: 15,
      orientation: Auto,
      step: 2,
      value: 40,
      wrap_detents: True,
    )

  let expected =
    element.element(
      "m3e-split-panel",
      [
        attribute.attribute("detents", "20 80"),
        attribute.attribute("label", "Config Label"),
        attribute.attribute("max", "85"),
        attribute.attribute("min", "15"),
        attribute.attribute("orientation", "auto"),
        attribute.attribute("step", "2"),
        attribute.attribute("value", "40"),
        attribute.attribute("wrap-detents", ""),
      ],
      [],
    )
  split_panel.render_config(config, [], []) |> should.equal(expected)
}

pub fn detents_test() {
  let sp = split_panel.new() |> split_panel.detents([10, 90])
  let expected =
    element.element(
      "m3e-split-panel",
      [attribute.attribute("detents", "10 90")],
      [],
    )
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn label_test() {
  let sp = split_panel.new() |> split_panel.label("New Label")
  let expected =
    element.element(
      "m3e-split-panel",
      [attribute.attribute("label", "New Label")],
      [],
    )
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn max_test() {
  let sp = split_panel.new() |> split_panel.max(80)
  let expected =
    element.element("m3e-split-panel", [attribute.attribute("max", "80")], [])
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn min_test() {
  let sp = split_panel.new() |> split_panel.min(20)
  let expected =
    element.element("m3e-split-panel", [attribute.attribute("min", "20")], [])
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn orientation_test() {
  let sp = split_panel.new() |> split_panel.orientation(Vertical)
  let expected =
    element.element(
      "m3e-split-panel",
      [attribute.attribute("orientation", "vertical")],
      [],
    )
  sp |> split_panel.render([], []) |> should.equal(expected)

  let sp2 = split_panel.new() |> split_panel.orientation(Auto)
  let expected2 =
    element.element(
      "m3e-split-panel",
      [attribute.attribute("orientation", "auto")],
      [],
    )
  sp2 |> split_panel.render([], []) |> should.equal(expected2)

  // Default orientation should not render the attribute
  let sp3 = split_panel.new() |> split_panel.orientation(Horizontal)
  let expected3 = element.element("m3e-split-panel", [], [])
  sp3 |> split_panel.render([], []) |> should.equal(expected3)
}

pub fn step_test() {
  let sp = split_panel.new() |> split_panel.step(10)
  let expected =
    element.element("m3e-split-panel", [attribute.attribute("step", "10")], [])
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn value_test() {
  let sp = split_panel.new() |> split_panel.value(75)
  let expected =
    element.element("m3e-split-panel", [attribute.attribute("value", "75")], [])
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn wrap_detents_test() {
  let sp = split_panel.new() |> split_panel.wrap_detents(True)
  let expected =
    element.element(
      "m3e-split-panel",
      [attribute.attribute("wrap-detents", "")],
      [],
    )
  sp |> split_panel.render([], []) |> should.equal(expected)
}

pub fn slot_test() {
  split_panel.slot(Start) |> should.equal(attribute.name("start"))
  split_panel.slot(End) |> should.equal(attribute.name("end"))
}

pub fn children_test() {
  let sp = split_panel.new()
  let child1 = element.text("Start content")
  let child2 = element.text("End content")
  let expected = element.element("m3e-split-panel", [], [child1, child2])
  split_panel.render(sp, [], [child1, child2]) |> should.equal(expected)
}
