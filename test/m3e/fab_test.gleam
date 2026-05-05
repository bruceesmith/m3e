//// Fab unit tests
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/fab.{Config}
import m3e/fab_size
import m3e/fab_variant
import m3e/form_submitter_type
import m3e/link_target

pub fn fab_default_config_test() {
  let cases = [
    Config(
      disabled: fab.IsNotDisabled,
      disabled_interactive: fab.IsNotDisabledInteractive,
      download: None,
      extended: fab.IsNotExtended,
      href: "",
      lowered: fab.IsNotLowered,
      name: "",
      rel: "",
      size: fab_size.Medium,
      target: None,
      type_: form_submitter_type.Button,
      value: "",
      variant: fab_variant.PrimaryContainer,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    fab.default_config()
    |> should.equal(expected)
  })
}

pub fn fab_from_config_test() {
  let cases = [
    #(
      fab.Config(
        disabled: fab.IsDisabled,
        disabled_interactive: fab.IsDisabledInteractive,
        download: Some("test"),
        extended: fab.IsExtended,
        href: "test",
        lowered: fab.IsLowered,
        name: "test",
        rel: "test",
        size: fab_size.Small,
        target: Some(link_target.Self),
        type_: form_submitter_type.Submit,
        value: "test",
        variant: fab_variant.Primary,
      ),
      fab.new()
        |> fab.disabled(fab.IsDisabled)
        |> fab.disabled_interactive(fab.IsDisabledInteractive)
        |> fab.download(Some("test"))
        |> fab.extended(fab.IsExtended)
        |> fab.href("test")
        |> fab.lowered(fab.IsLowered)
        |> fab.name("test")
        |> fab.rel("test")
        |> fab.size(fab_size.Small)
        |> fab.target(Some(link_target.Self))
        |> fab.type_(form_submitter_type.Submit)
        |> fab.value("test")
        |> fab.variant(fab_variant.Primary),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    fab.from_config(config)
    |> should.equal(expected)
  })
}

pub fn fab_new_test() {
  let cases = [
    fab.from_config(fab.Config(
      disabled: fab.IsNotDisabled,
      disabled_interactive: fab.IsNotDisabledInteractive,
      download: None,
      extended: fab.IsNotExtended,
      href: "",
      lowered: fab.IsNotLowered,
      name: "",
      rel: "",
      size: fab_size.Medium,
      target: None,
      type_: form_submitter_type.Button,
      value: "",
      variant: fab_variant.PrimaryContainer,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    fab.new()
    |> should.equal(expected)
  })
}

pub fn fab_disabled_test() {
  let mod = fab.new()
  let cases = [
    #(
      fab.IsDisabled,
      fab.from_config(
        fab.Config(..fab.default_config(), disabled: fab.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_disabled_interactive_test() {
  let mod = fab.new()
  let cases = [
    #(
      fab.IsDisabledInteractive,
      fab.from_config(
        fab.Config(
          ..fab.default_config(),
          disabled_interactive: fab.IsDisabledInteractive,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.disabled_interactive(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_download_test() {
  let mod = fab.new()
  let cases = [
    #(
      Some("test"),
      fab.from_config(
        fab.Config(..fab.default_config(), download: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.download(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_extended_test() {
  let mod = fab.new()
  let cases = [
    #(
      fab.IsExtended,
      fab.from_config(
        fab.Config(..fab.default_config(), extended: fab.IsExtended),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.extended(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_href_test() {
  let mod = fab.new()
  let cases = [
    #("test", fab.from_config(fab.Config(..fab.default_config(), href: "test"))),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.href(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_lowered_test() {
  let mod = fab.new()
  let cases = [
    #(
      fab.IsLowered,
      fab.from_config(
        fab.Config(..fab.default_config(), lowered: fab.IsLowered),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.lowered(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_name_test() {
  let mod = fab.new()
  let cases = [
    #("test", fab.from_config(fab.Config(..fab.default_config(), name: "test"))),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_rel_test() {
  let mod = fab.new()
  let cases = [
    #("test", fab.from_config(fab.Config(..fab.default_config(), rel: "test"))),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.rel(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_size_test() {
  let mod = fab.new()
  let cases = [
    #(
      fab_size.Small,
      fab.from_config(fab.Config(..fab.default_config(), size: fab_size.Small)),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.size(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_target_test() {
  let mod = fab.new()
  let cases = [
    #(
      Some(link_target.Self),
      fab.from_config(
        fab.Config(..fab.default_config(), target: Some(link_target.Self)),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.target(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_type__test() {
  let mod = fab.new()
  let cases = [
    #(
      form_submitter_type.Submit,
      fab.from_config(
        fab.Config(..fab.default_config(), type_: form_submitter_type.Submit),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.type_(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_value_test() {
  let mod = fab.new()
  let cases = [
    #(
      "test",
      fab.from_config(fab.Config(..fab.default_config(), value: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_variant_test() {
  let mod = fab.new()
  let cases = [
    #(
      fab_variant.Primary,
      fab.from_config(
        fab.Config(..fab.default_config(), variant: fab_variant.Primary),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    fab.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn fab_render_test() {
  let mod = fab.new()

  let mod_disabled = fab.new() |> fab.disabled(fab.IsDisabled)
  let mod_disabled_interactive =
    fab.new() |> fab.disabled_interactive(fab.IsDisabledInteractive)
  let mod_download = fab.new() |> fab.download(Some("test"))
  let mod_extended = fab.new() |> fab.extended(fab.IsExtended)
  let mod_href = fab.new() |> fab.href("test")
  let mod_lowered = fab.new() |> fab.lowered(fab.IsLowered)
  let mod_name = fab.new() |> fab.name("test")
  let mod_rel = fab.new() |> fab.rel("test")
  let mod_size = fab.new() |> fab.size(fab_size.Small)
  let mod_target = fab.new() |> fab.target(Some(link_target.Self))
  let mod_type_ = fab.new() |> fab.type_(form_submitter_type.Submit)
  let mod_value = fab.new() |> fab.value("test")
  let mod_variant = fab.new() |> fab.variant(fab_variant.Primary)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-fab", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-fab", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(#(mod, [], [html.br([])]), element.element("m3e-fab", [], [html.br([])])),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-fab", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a disabled_interactive attribute
    #(
      #(mod_disabled_interactive, [], []),
      element.element(
        "m3e-fab",
        [attribute.attribute("disabled-interactive", "")],
        [],
      ),
    ),
    // Happy path with a download attribute
    #(
      #(mod_download, [], []),
      element.element("m3e-fab", [attribute.attribute("download", "test")], []),
    ),
    // Happy path with a extended attribute
    #(
      #(mod_extended, [], []),
      element.element("m3e-fab", [attribute.attribute("extended", "")], []),
    ),
    // Happy path with a href attribute
    #(
      #(mod_href, [], []),
      element.element("m3e-fab", [attribute.attribute("href", "test")], []),
    ),
    // Happy path with a lowered attribute
    #(
      #(mod_lowered, [], []),
      element.element("m3e-fab", [attribute.attribute("lowered", "")], []),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element("m3e-fab", [attribute.attribute("name", "test")], []),
    ),
    // Happy path with a rel attribute
    #(
      #(mod_rel, [], []),
      element.element("m3e-fab", [attribute.attribute("rel", "test")], []),
    ),
    // Happy path with a size attribute
    #(
      #(mod_size, [], []),
      element.element(
        "m3e-fab",
        [attribute.attribute("size", fab_size.to_string(fab_size.Small))],
        [],
      ),
    ),
    // Happy path with a target attribute
    #(
      #(mod_target, [], []),
      element.element(
        "m3e-fab",
        [attribute.attribute("target", link_target.to_string(link_target.Self))],
        [],
      ),
    ),
    // Happy path with a type_ attribute
    #(
      #(mod_type_, [], []),
      element.element(
        "m3e-fab",
        [
          attribute.attribute(
            "type",
            form_submitter_type.to_string(form_submitter_type.Submit),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element("m3e-fab", [attribute.attribute("value", "test")], []),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-fab",
        [
          attribute.attribute(
            "variant",
            fab_variant.to_string(fab_variant.Primary),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    fab.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn fab_slot_test() {
  let cases = [
    #(fab.Label, attribute.attribute("slot", "label")),
    #(fab.CloseIcon, attribute.attribute("slot", "close-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    fab.slot(s)
    |> should.equal(expected)
  })
}
