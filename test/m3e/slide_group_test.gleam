import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/layout.{Horizontal, Vertical}
import m3e/slide_group
import m3e/state.{Disabled, Enabled}

pub fn slide_group_creation_test() {
  let s = slide_group.new()
  let expected =
    element.element(
      "m3e-slide-group",
      [
        attribute.attribute("next-page-label", "Next page"),
        attribute.attribute("previous-page-label", "Previous page"),
        attribute.attribute("threshold", "0"),
      ],
      [],
    )
  slide_group.render(s, [], []) |> should.equal(expected)
}

pub fn slide_group_setters_test() {
  let s =
    slide_group.new()
    |> slide_group.disabled(Disabled)
    |> slide_group.next_page_label("Next")
    |> slide_group.previous_page_label("Prev")
    |> slide_group.threshold(100)
    |> slide_group.vertical(Vertical)

  let expected =
    element.element(
      "m3e-slide-group",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("next-page-label", "Next"),
        attribute.attribute("previous-page-label", "Prev"),
        attribute.attribute("threshold", "100"),
        attribute.attribute("vertical", ""),
      ],
      [element.text("Child")],
    )
  slide_group.render(s, [], [element.text("Child")]) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    slide_group.Config(
      interaction: Disabled,
      next_page_label: "Forward",
      previous_page_label: "Back",
      threshold: 50,
      orientation: Vertical,
    )

  let s = slide_group.from_config(c)

  slide_group.render(s, [], [])
  |> should.equal(
    element.element(
      "m3e-slide-group",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("next-page-label", "Forward"),
        attribute.attribute("previous-page-label", "Back"),
        attribute.attribute("threshold", "50"),
        attribute.attribute("vertical", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = slide_group.default_config()

  c.interaction |> should.equal(Enabled)
  c.next_page_label |> should.equal("Next page")
  c.previous_page_label |> should.equal("Previous page")
  c.threshold |> should.equal(0)
  c.orientation |> should.equal(Horizontal)
}

pub fn from_config_test() {
  let c = slide_group.default_config()
  let s = slide_group.from_config(c)

  slide_group.render(s, [], [])
  |> should.equal(slide_group.render(slide_group.new(), [], []))
}

pub fn render_config_test() {
  let c = slide_group.default_config()
  let expected = slide_group.render(slide_group.from_config(c), [], [])

  slide_group.render_config(c, [], [])
  |> should.equal(expected)
}
