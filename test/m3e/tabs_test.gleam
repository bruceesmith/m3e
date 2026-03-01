import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/tabs.{
  After, Primary, disabled_pagination, header_position, new, next_page_label,
  previous_page_label, render, stretch, variant,
}

pub fn tabs_new_test() {
  new()
  |> render([], [])
  |> should.equal(
    element(
      "m3e-tabs",
      [
        attribute("header-position", "before"),
        attribute("next-page-label", "Next page"),
        attribute("previous-page-label", "Previous page"),
        attribute("variant", "secondary"),
      ],
      [],
    ),
  )
}

pub fn tabs_full_test() {
  new()
  |> disabled_pagination(True)
  |> header_position(After)
  |> next_page_label("Following")
  |> previous_page_label("Preceding")
  |> stretch(True)
  |> variant(Primary)
  |> render([attribute("id", "tabs-1")], [element.text("Children")])
  |> should.equal(
    element(
      "m3e-tabs",
      [
        attribute("disabled-pagination", ""),
        attribute("header-position", "after"),
        attribute("next-page-label", "Following"),
        attribute("previous-page-label", "Preceding"),
        attribute("stretch", ""),
        attribute("variant", "primary"),
        attribute("id", "tabs-1"),
      ],
      [element.text("Children")],
    ),
  )
}
