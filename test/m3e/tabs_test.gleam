import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/tabs.{
  After, NoScroll, Primary, Stretch, disabled_pagination, header_position, new,
  next_page_label, previous_page_label, render, stretch, variant,
}

pub fn tabs_new_test() {
  new()
  |> render([], [])
  |> should.equal(
    element.element(
      "m3e-tabs",
      [
        attribute.attribute("header-position", "before"),
        attribute.attribute("next-page-label", "Next page"),
        attribute.attribute("previous-page-label", "Previous page"),
        attribute.attribute("variant", "secondary"),
      ],
      [],
    ),
  )
}

pub fn tabs_full_test() {
  new()
  |> disabled_pagination(NoScroll)
  |> header_position(After)
  |> next_page_label("Following")
  |> previous_page_label("Preceding")
  |> stretch(Stretch)
  |> variant(Primary)
  |> render([attribute.attribute("id", "tabs-1")], [element.text("Children")])
  |> should.equal(
    element.element(
      "m3e-tabs",
      [
        attribute.attribute("disabled-pagination", ""),
        attribute.attribute("header-position", "after"),
        attribute.attribute("next-page-label", "Following"),
        attribute.attribute("previous-page-label", "Preceding"),
        attribute.attribute("stretch", ""),
        attribute.attribute("variant", "primary"),
        attribute.attribute("id", "tabs-1"),
      ],
      [element.text("Children")],
    ),
  )
}
