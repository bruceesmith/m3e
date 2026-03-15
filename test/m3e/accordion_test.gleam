import gleeunit/should
import lustre/attribute.{attribute}
import lustre/element.{element}
import m3e/accordion

pub fn accordion_test() {
  let a = accordion.new() |> accordion.multi(True)
  let expected = element("m3e-accordion", [attribute("multi", "")], [])
  accordion.render(a, [], []) |> should.equal(expected)
}

pub fn defaults_test() {
  let a = accordion.new()
  let expected = element("m3e-accordion", [], [])
  accordion.render(a, [], []) |> should.equal(expected)
}

pub fn from_config_test() {
  let config = accordion.Config(multi: True)
  let a = accordion.from_config(config)
  let expected = element("m3e-accordion", [attribute("multi", "")], [])
  accordion.render(a, [], []) |> should.equal(expected)
}

pub fn render_config_defaults_test() {
  let config = accordion.default_config()
  let expected = element("m3e-accordion", [], [])
  accordion.render_config(config, [], []) |> should.equal(expected)
}

pub fn render_config_multi_test() {
  let config = accordion.Config(multi: True)
  let expected = element("m3e-accordion", [attribute("multi", "")], [])
  accordion.render_config(config, [], []) |> should.equal(expected)
}
