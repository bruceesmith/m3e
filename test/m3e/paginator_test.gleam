import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html.{text}
import m3e/form_field.{Filled}
import m3e/paginator.{
  PageSize, PageSizeAll, disabled, first_page_label, hide_page_size,
  items_per_page_label, last_page_label, length, new, next_page_label,
  page_index, page_size, page_size_variant, page_sizes, previous_page_label,
  render, show_first_last_buttons,
}

pub fn paginator_creation_test() {
  let p = new()
  let expected =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "0"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p, [], []) |> should.equal(expected)
}

pub fn paginator_full_test() {
  let p =
    new()
    |> disabled(paginator.Disabled)
    |> first_page_label("Primeira")
    |> hide_page_size(paginator.Hidden)
    |> items_per_page_label("Itens")
    |> last_page_label("Última")
    |> length(1000)
    |> next_page_label("Próxima")
    |> page_index(1)
    |> page_size(PageSize(10))
    |> page_sizes([PageSize(10), PageSize(20), PageSizeAll])
    |> page_size_variant(Filled)
    |> previous_page_label("Anterior")
    |> show_first_last_buttons(paginator.Shown)

  let expected =
    element(
      "m3e-paginator",
      [
        attribute("disabled", ""),
        attribute("first-page-label", "Primeira"),
        attribute("hide-page-size", ""),
        attribute("items-per-page-label", "Itens"),
        attribute("last-page-label", "Última"),
        attribute("length", "1000"),
        attribute("next-page-label", "Próxima"),
        attribute("page-index", "1"),
        attribute("page-size", "10"),
        attribute("page-sizes", "10,20,all"),
        attribute("page-size-variant", "filled"),
        attribute("previous-page-label", "Anterior"),
        attribute("show-first-last-buttons", ""),
      ],
      [],
    )
  render(p, [], []) |> should.equal(expected)
}

pub fn paginator_element_test() {
  let p = new()
  let expected =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "0"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [text("Child")],
    )
  p |> render([], [text("Child")]) |> should.equal(expected)
}

pub fn paginator_setters_test() {
  let p = new()

  let p_disabled = p |> disabled(paginator.Disabled)
  let expected_disabled =
    element(
      "m3e-paginator",
      [
        attribute("disabled", ""),
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "0"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_disabled, [], []) |> should.equal(expected_disabled)

  let p_hide = p |> hide_page_size(paginator.Hidden)
  let expected_hide =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("hide-page-size", ""),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "0"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_hide, [], []) |> should.equal(expected_hide)

  let p_show = p |> show_first_last_buttons(paginator.Shown)
  let expected_show =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "0"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
        attribute("show-first-last-buttons", ""),
      ],
      [],
    )
  render(p_show, [], []) |> should.equal(expected_show)
}

pub fn config_test() {
  let c =
    paginator.Config(
      interaction: paginator.Disabled,
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

  render(p, [], [])
  |> should.equal(
    element(
      "m3e-paginator",
      [
        attribute("disabled", ""),
        attribute("first-page-label", "First"),
        attribute("hide-page-size", ""),
        attribute("items-per-page-label", "Items"),
        attribute("last-page-label", "Last"),
        attribute("length", "100"),
        attribute("next-page-label", "Next"),
        attribute("page-index", "5"),
        attribute("page-size", "10"),
        attribute("page-sizes", "10,all"),
        attribute("page-size-variant", "filled"),
        attribute("previous-page-label", "Prev"),
        attribute("show-first-last-buttons", ""),
      ],
      [],
    ),
  )
}

pub fn default_config_test() {
  let c = paginator.default_config()

  c.interaction |> should.equal(paginator.Enabled)
  c.page_size_visibility |> should.equal(paginator.Visible)
  c.first_last_buttons_visibility |> should.equal(paginator.Omitted)
  c.length |> should.equal(0)
  c.page_index |> should.equal(0)
  c.page_size |> should.equal(PageSize(50))
}

pub fn from_config_test() {
  let c = paginator.default_config()
  let p = paginator.from_config(c)

  render(p, [], [])
  |> should.equal(render(new(), [], []))
}

pub fn render_config_test() {
  let c = paginator.default_config()
  let expected = render(paginator.from_config(c), [], [])

  paginator.render_config(c, [], [])
  |> should.equal(expected)
}
