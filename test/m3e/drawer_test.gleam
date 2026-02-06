import gleeunit/should
import lustre/attribute.{attribute, none}
import lustre/element
import lustre/element/html.{div, text}
import m3e/drawer.{
  End, Over, Push, Side, Start, content, divider, drawer, empty, id, mode, open,
  render, usage,
}

pub fn drawer_creation_test() {
  let d = empty()
  let #(attrs, elt) = render(d)
  attrs |> should.equal([none()])
  elt |> should.equal(element.none())
}

pub fn drawer_start_test() {
  let content_elt = div([], [text("Start Content")])
  let d = drawer(Start, Side, True, "start-id", True, content_elt)

  let #(attrs, elt) = render(d)

  let expected_attrs = [
    attribute("start", ""),
    attribute("start-divider", ""),
    attribute("start-mode", "side"),
  ]
  attrs |> should.equal(expected_attrs)

  let expected_elt =
    div([attribute("slot", "start"), attribute("id", "start-id")], [content_elt])
  elt |> should.equal(expected_elt)
}

pub fn drawer_end_test() {
  let content_elt = div([], [text("End Content")])
  let d = drawer(End, Push, False, "", False, content_elt)

  let #(attrs, elt) = render(d)

  let expected_attrs = [
    none(),
    none(),
    attribute("end-mode", "push"),
  ]
  attrs |> should.equal(expected_attrs)

  let expected_elt = div([attribute("slot", "end"), none()], [content_elt])
  elt |> should.equal(expected_elt)
}

pub fn drawer_setters_test() {
  let d =
    empty()
    |> usage(Start)
    |> mode(Over)
    |> open(True)
    |> divider(True)
    |> id("my-drawer")
    |> content(text("Hello"))

  let #(attrs, elt) = render(d)

  let expected_attrs = [
    attribute("start", ""),
    attribute("start-divider", ""),
    attribute("start-mode", "over"),
  ]
  attrs |> should.equal(expected_attrs)

  let expected_elt =
    div([attribute("slot", "start"), attribute("id", "my-drawer")], [
      text("Hello"),
    ])
  elt |> should.equal(expected_elt)
}
