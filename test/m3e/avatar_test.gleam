import gleeunit/should

import lustre/element.{element}

import m3e/avatar.{new, render}

pub fn avatar_basic_test() {
  let a = new()
  let expected = element("m3e-avatar", [], [])
  render(a, []) |> should.equal(expected)
}

pub fn avatar_children_test() {
  let a = new()
  let children = [element.text("JD")]
  let expected = element("m3e-avatar", [], children)
  render(a, children) |> should.equal(expected)
}
