import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import m3e/link.{
  Blank, Link, Parent, Self, Top, download, href, link_target_to_string, new,
  rel, target,
}

pub fn link_target_to_string_test() {
  link_target_to_string(Blank) |> should.equal("_blank")
  link_target_to_string(Parent) |> should.equal("_parent")
  link_target_to_string(Self) |> should.equal("_self")
  link_target_to_string(Top) |> should.equal("_top")
}

pub fn link_creation_test() {
  let l = new("https://example.com")
  l.download |> should.be_false
  l.href |> should.equal("https://example.com")
  l.rel |> should.equal("")
  l.target |> should.equal(Self)
}

pub fn link_updates_test() {
  new("")
  |> download(True)
  |> href("https://gleam.run")
  |> rel("author")
  |> target(Blank)
  |> should.equal(Link(
    download: True,
    href: "https://gleam.run",
    rel: "author",
    target: Blank,
  ))
}

pub fn link_attributes_test() {
  // Test None
  link.attributes(None) |> should.equal([])
}

pub fn link_attributes_test1() {
  // Test Some with empty href
  new("")
  |> Some
  |> link.attributes
  |> should.equal([])
}

pub fn link_attributes_test2() {
  // Test Some with valid href
  let l =
    new("https://example.com")
    |> download(True)
    |> rel("external")
    |> target(Blank)
  link.attributes(Some(l))
  |> should.equal([
    attribute.attribute("download", ""),
    attribute.attribute("href", "https://example.com"),
    attribute.attribute("rel", "external"),
    attribute.attribute("target", "_blank"),
  ])
}

pub fn link_attributes_test3() {
  // Test Some with valid href and download False
  let l2 = new("/home")
  link.attributes(Some(l2))
  |> should.equal([
    attribute.attribute("href", "/home"),
    attribute.attribute("target", "_self"),
  ])
}
