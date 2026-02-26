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
    |> disabled(True)
    |> first_page_label("Primeira")
    |> hide_page_size(True)
    |> items_per_page_label("Itens")
    |> last_page_label("Última")
    |> length(1000)
    |> next_page_label("Próxima")
    |> page_index(1)
    |> page_size(PageSize(10))
    |> page_sizes([PageSize(10), PageSize(20), PageSizeAll])
    |> page_size_variant(Filled)
    |> previous_page_label("Anterior")
    |> show_first_last_buttons(True)

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

  let p_disabled = p |> disabled(True)
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

  let p_first = p |> first_page_label("First")
  let expected_first =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First"),
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
  render(p_first, [], []) |> should.equal(expected_first)

  let p_hide = p |> hide_page_size(True)
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

  let p_items = p |> items_per_page_label("Items")
  let expected_items =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items"),
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
  render(p_items, [], []) |> should.equal(expected_items)

  let p_last = p |> last_page_label("Last")
  let expected_last =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last"),
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
  render(p_last, [], []) |> should.equal(expected_last)

  let p_len = p |> length(99)
  let expected_len =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "99"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "0"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_len, [], []) |> should.equal(expected_len)

  let p_next = p |> next_page_label("Next")
  let expected_next =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next"),
        attribute("page-index", "0"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_next, [], []) |> should.equal(expected_next)

  let p_idx = p |> page_index(2)
  let expected_idx =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "2"),
        attribute("page-size", "50"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_idx, [], []) |> should.equal(expected_idx)

  let p_psize = p |> page_size(PageSize(10))
  let expected_psize =
    element(
      "m3e-paginator",
      [
        attribute("first-page-label", "First page"),
        attribute("items-per-page-label", "Items per page"),
        attribute("last-page-label", "Last page"),
        attribute("length", "0"),
        attribute("next-page-label", "Next page"),
        attribute("page-index", "0"),
        attribute("page-size", "10"),
        attribute("page-sizes", "5,10,25,50,100"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_psize, [], []) |> should.equal(expected_psize)

  let p_psizes = p |> page_sizes([PageSize(1), PageSizeAll])
  let expected_psizes =
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
        attribute("page-sizes", "1,all"),
        attribute("page-size-variant", "outlined"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_psizes, [], []) |> should.equal(expected_psizes)

  let p_pvariant = p |> page_size_variant(Filled)
  let expected_pvariant =
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
        attribute("page-size-variant", "filled"),
        attribute("previous-page-label", "Previous page"),
      ],
      [],
    )
  render(p_pvariant, [], []) |> should.equal(expected_pvariant)

  let p_prev = p |> previous_page_label("Previous")
  let expected_prev =
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
        attribute("previous-page-label", "Previous"),
      ],
      [],
    )
  render(p_prev, [], []) |> should.equal(expected_prev)

  let p_show = p |> show_first_last_buttons(True)
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
