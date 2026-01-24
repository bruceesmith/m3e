import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html.{div, text}
import m3e/drawer_container.{
  Auto, Over, Push, Side, basic, draw_container, element, end, end_divider,
  end_mode, start, start_divider, start_mode,
}

pub fn drawer_container_creation_test() {
  let c = basic()
  c.end |> should.be_false()
  c.end_divider |> should.be_false()
  c.end_mode |> should.equal(Auto)
  c.start |> should.be_false()
  c.start_divider |> should.be_false()
  c.start_mode |> should.equal(Auto)

  let c = draw_container(True, True, Side, True, True, Push)
  c.end |> should.be_true()
  c.end_divider |> should.be_true()
  c.end_mode |> should.equal(Side)
  c.start |> should.be_true()
  c.start_divider |> should.be_true()
  c.start_mode |> should.equal(Push)
}

pub fn drawer_container_helpers_test() {
  let c =
    basic()
    |> end(True)
    |> end_divider(True)
    |> end_mode(Over)
    |> start(True)
    |> start_divider(True)
    |> start_mode(Side)

  c.end |> should.be_true()
  c.end_divider |> should.be_true()
  c.end_mode |> should.equal(Over)
  c.start |> should.be_true()
  c.start_divider |> should.be_true()
  c.start_mode |> should.equal(Side)
}

pub fn drawer_container_element_test() {
  let c = basic()
  let expected =
    element.element("m3e-drawer-container", [], [div([], [text("content")])])
  c |> element([], [div([], [text("content")])]) |> should.equal(expected)

  // Test with 'end' enabled
  let c = basic() |> end(True) |> end_mode(Push)
  let expected =
    element.element(
      "m3e-drawer-container",
      [
        attribute("end", ""),
        attribute.none(),
        // end_divider is False
        attribute("end-mode", "push"),
      ],
      [],
    )
  c |> element([], []) |> should.equal(expected)

  // Test with 'start' enabled
  let c = basic() |> start(True) |> start_divider(True) |> start_mode(Side)
  let expected =
    element.element(
      "m3e-drawer-container",
      [
        attribute("start", ""),
        attribute("start-divider", ""),
        attribute("start-mode", "side"),
      ],
      [],
    )
  c |> element([], []) |> should.equal(expected)
}
