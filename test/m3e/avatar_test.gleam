import gleeunit/should

import lustre/element

import m3e/avatar

pub fn avatar_basic_test() {
  let a = avatar.new()
  let expected = element.element("m3e-avatar", [], [])
  avatar.render(a, []) |> should.equal(expected)
}

pub fn avatar_children_test() {
  let a = avatar.new()
  let children = [element.text("JD")]
  let expected = element.element("m3e-avatar", [], children)
  avatar.render(a, children) |> should.equal(expected)
}
