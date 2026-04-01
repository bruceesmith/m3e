import gleeunit/should
import lustre/attribute
import lustre/element

import m3e/form_field.{Filled}
import m3e/paginator.{PageSize, PageSizeAll}
import m3e/state.{Disabled, Enabled}

pub fn paginator_creation_test() {
  let p = paginator.new()
  let expected =
    element.element(
      "m3e-paginator",
      [
        attribute.attribute("first-page-label", "First page"),
        attribute.attribute("items-per-page-label", "Items per page"),
        attribute.attribute("last-page-label", "Last page"),
        attribute.attribute("length", "0"),
        attribute.attribute("next-page-label", "Next page"),
        attribute.attribute("page-index", "0"),
        attribute.attribute("page-size", "50"),
        attribute.attribute("page-sizes", "5,10,25,50,100"),
        attribute.attribute("page-size-variant", "outlined"),
        attribute.attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  paginator.render(p, [], []) |> should.equal(expected)
}

pub fn paginator_full_test() {
  let p =
    paginator.new()
    |> paginator.disabled(Disabled)
    |> paginator.first_page_label("Primeira")
    |> paginator.hide_page_size(paginator.Hidden)
    |> paginator.items_per_page_label("Itens")
    |> paginator.last_page_label("Última")
    |> paginator.length(1000)
    |> paginator.next_page_label("Próxima")
    |> paginator.page_index(1)
    |> paginator.page_size(PageSize(10))
    |> paginator.page_sizes([PageSize(10), PageSize(20), PageSizeAll])
    |> paginator.page_size_variant(Filled)
    |> paginator.previous_page_label("Anterior")
    |> paginator.show_first_last_buttons(paginator.Shown)

  let expected =
    element.element(
      "m3e-paginator",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("first-page-label", "Primeira"),
        attribute.attribute("hide-page-size", ""),
        attribute.attribute("items-per-page-label", "Itens"),
        attribute.attribute("last-page-label", "Última"),
        attribute.attribute("length", "1000"),
        attribute.attribute("next-page-label", "Próxima"),
        attribute.attribute("page-index", "1"),
        attribute.attribute("page-size", "10"),
        attribute.attribute("page-sizes", "10,20,all"),
        attribute.attribute("page-size-variant", "filled"),
        attribute.attribute("previous-page-label", "Anterior"),
        attribute.attribute("show-first-last-buttons", ""),
      ],
      [],
    )
  paginator.render(p, [], []) |> should.equal(expected)
}

pub fn paginator_element_test() {
  let p = paginator.new()
  let expected =
    element.element(
      "m3e-paginator",
      [
        attribute.attribute("first-page-label", "First page"),
        attribute.attribute("items-per-page-label", "Items per page"),
        attribute.attribute("last-page-label", "Last page"),
        attribute.attribute("length", "0"),
        attribute.attribute("next-page-label", "Next page"),
        attribute.attribute("page-index", "0"),
        attribute.attribute("page-size", "50"),
        attribute.attribute("page-sizes", "5,10,25,50,100"),
        attribute.attribute("page-size-variant", "outlined"),
        attribute.attribute("previous-page-label", "Previous page"),
      ],
      [element.text("Child")],
    )
  p |> paginator.render([], [element.text("Child")]) |> should.equal(expected)
}

pub fn paginator_setters_test() {
  let p = paginator.new()

  let p_disabled = p |> paginator.disabled(Disabled)
  let expected_disabled =
    element.element(
      "m3e-paginator",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("first-page-label", "First page"),
        attribute.attribute("items-per-page-label", "Items per page"),
        attribute.attribute("last-page-label", "Last page"),
        attribute.attribute("length", "0"),
        attribute.attribute("next-page-label", "Next page"),
        attribute.attribute("page-index", "0"),
        attribute.attribute("page-size", "50"),
        attribute.attribute("page-sizes", "5,10,25,50,100"),
        attribute.attribute("page-size-variant", "outlined"),
        attribute.attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  paginator.render(p_disabled, [], []) |> should.equal(expected_disabled)

  let p_hide = p |> paginator.hide_page_size(paginator.Hidden)
  let expected_hide =
    element.element(
      "m3e-paginator",
      [
        attribute.attribute("first-page-label", "First page"),
        attribute.attribute("hide-page-size", ""),
        attribute.attribute("items-per-page-label", "Items per page"),
        attribute.attribute("last-page-label", "Last page"),
        attribute.attribute("length", "0"),
        attribute.attribute("next-page-label", "Next page"),
        attribute.attribute("page-index", "0"),
        attribute.attribute("page-size", "50"),
        attribute.attribute("page-sizes", "5,10,25,50,100"),
        attribute.attribute("page-size-variant", "outlined"),
        attribute.attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  paginator.render(p_hide, [], []) |> should.equal(expected_hide)

  let p_show = p |> paginator.show_first_last_buttons(paginator.Shown)
  let expected_show =
    element.element(
      "m3e-paginator",
      [
        attribute.attribute("first-page-label", "First page"),
        attribute.attribute("items-per-page-label", "Items per page"),
        attribute.attribute("last-page-label", "Last page"),
        attribute.attribute("length", "0"),
        attribute.attribute("next-page-label", "Next page"),
        attribute.attribute("page-index", "0"),
        attribute.attribute("page-size", "50"),
        attribute.attribute("page-sizes", "5,10,25,50,100"),
        attribute.attribute("page-size-variant", "outlined"),
        attribute.attribute("previous-page-label", "Previous page"),
        attribute.attribute("show-first-last-buttons", ""),
      ],
      [],
    )
  paginator.render(p_show, [], []) |> should.equal(expected_show)
}

pub fn config_test() {
  let c =
    paginator.Config(
      disabled: Disabled,
      first_page_label: "First",
      page_size_visibility: paginator.Hidden,
      items_per_page_label: "Items",
      last_page_label: "Last",
      length: 100,
      next_page_label: "Next",
      page_index: 5,
      page_size: PageSize(10),
      page_sizes: [PageSize(10), PageSizeAll],
      page_size_variant: Filled,
      previous_page_label: "Prev",
      first_last_buttons_visibility: paginator.Shown,
    )

  let p = paginator.from_config(c)

  paginator.render(p, [], [])
  |> should.equal(
    element.element(
      "m3e-paginator",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("first-page-label", "First"),
        attribute.attribute("hide-page-size", ""),
        attribute.attribute("items-per-page-label", "Items"),
        attribute.attribute("last-page-label", "Last"),
        attribute.attribute("length", "100"),
        attribute.attribute("next-page-label", "Next"),
        attribute.attribute("page-index", "5"),
        attribute.attribute("page-size", "10"),
        attribute.attribute("page-sizes", "10,all"),
        attribute.attribute("page-size-variant", "filled"),
        attribute.attribute("previous-page-label", "Prev"),
        attribute.attribute("show-first-last-buttons", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = paginator.default_config()

  c.disabled |> should.equal(Enabled)
  c.page_size_visibility |> should.equal(paginator.Visible)
  c.first_last_buttons_visibility |> should.equal(paginator.Omitted)
  c.length |> should.equal(0)
  c.page_index |> should.equal(0)
  c.page_size |> should.equal(PageSize(50))
}

pub fn from_config_test() {
  let c = paginator.default_config()
  let p = paginator.from_config(c)

  paginator.render(p, [], [])
  |> should.equal(paginator.render(paginator.new(), [], []))
}

pub fn render_config_test() {
  let c = paginator.default_config()
  let expected = paginator.render(paginator.from_config(c), [], [])

  paginator.render_config(c, [], [])
  |> should.equal(expected)
}
