import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/slide_group.{
  disabled, new, next_page_label, previous_page_label, render, threshold,
  vertical,
}

pub fn slide_group_creation_test() {
  let s = new()
  let expected =
    element(
      "m3e-slide-group",
      [
        attribute("next-page-label", "Next page"),
        attribute("previous-page-label", "Previous page"),
        attribute("threshold", "0"),
      ],
      [],
    )
  render(s, [], []) |> should.equal(expected)
}

pub fn slide_group_setters_test() {
  let s =
    new()
    |> disabled(slide_group.Disabled)
    |> next_page_label("Next")
    |> previous_page_label("Prev")
    |> threshold(100)
    |> vertical(slide_group.Vertical)

  let expected =
    element(
      "m3e-slide-group",
      [
        attribute("disabled", ""),
        attribute("next-page-label", "Next"),
        attribute("previous-page-label", "Prev"),
        attribute("threshold", "100"),
        attribute("vertical", ""),
      ],
      [text("Child")],
    )
  render(s, [], [text("Child")]) |> should.equal(expected)
}

pub fn config_test() {
  let c =
    slide_group.Config(
      interaction: slide_group.Disabled,
      next_page_label: "Forward",
      previous_page_label: "Back",
      threshold: 50,
      orientation: slide_group.Vertical,
    )

  let s = slide_group.from_config(c)

  render(s, [], [])
  |> should.equal(
    element(
      "m3e-slide-group",
      [
        attribute("disabled", ""),
        attribute("next-page-label", "Forward"),
        attribute("previous-page-label", "Back"),
        attribute("threshold", "50"),
        attribute("vertical", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = slide_group.default_config()

  c.interaction |> should.equal(slide_group.Enabled)
  c.next_page_label |> should.equal("Next page")
  c.previous_page_label |> should.equal("Previous page")
  c.threshold |> should.equal(0)
  c.orientation |> should.equal(slide_group.Horizontal)
}

pub fn from_config_test() {
  let c = slide_group.default_config()
  let s = slide_group.from_config(c)

  render(s, [], [])
  |> should.equal(render(new(), [], []))
}

pub fn render_config_test() {
  let c = slide_group.default_config()
  let expected = render(slide_group.from_config(c), [], [])

  slide_group.render_config(c, [], [])
  |> should.equal(expected)
}
