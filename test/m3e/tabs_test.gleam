import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/tabs.{After, NoScroll, Primary, Stretch}

pub fn tabs_new_test() {
  tabs.new()
  |> tabs.render([], [])
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
  tabs.new()
  |> tabs.disable_pagination(NoScroll)
  |> tabs.header_position(After)
  |> tabs.next_page_label("Following")
  |> tabs.previous_page_label("Preceding")
  |> tabs.stretch(Stretch)
  |> tabs.variant(Primary)
  |> tabs.render([attribute.attribute("id", "tabs-1")], [
    element.text("Children"),
  ])
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
