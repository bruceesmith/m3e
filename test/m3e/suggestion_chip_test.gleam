//// SuggestionChip unit tests
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
import m3e/chip_variant
import m3e/form_submitter_type
import m3e/link_target
import m3e/suggestion_chip.{Config}

pub fn suggestion_chip_default_config_test() {
  let cases = [
    Config(
      disabled: suggestion_chip.IsNotDisabled,
      disabled_interactive: suggestion_chip.IsNotDisabledInteractive,
      download: None,
      href: "",
      name: "",
      rel: "",
      target: None,
      type_: form_submitter_type.Button,
      value: "",
      variant: chip_variant.Outlined,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    suggestion_chip.default_config()
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_from_config_test() {
  let cases = [
    #(
      suggestion_chip.Config(
        disabled: suggestion_chip.IsDisabled,
        disabled_interactive: suggestion_chip.IsDisabledInteractive,
        download: Some("test"),
        href: "test",
        name: "test",
        rel: "test",
        target: Some(link_target.Self),
        type_: form_submitter_type.Submit,
        value: "test",
        variant: chip_variant.Elevated,
      ),
      suggestion_chip.new()
        |> suggestion_chip.disabled(suggestion_chip.IsDisabled)
        |> suggestion_chip.disabled_interactive(
          suggestion_chip.IsDisabledInteractive,
        )
        |> suggestion_chip.download(Some("test"))
        |> suggestion_chip.href("test")
        |> suggestion_chip.name("test")
        |> suggestion_chip.rel("test")
        |> suggestion_chip.target(Some(link_target.Self))
        |> suggestion_chip.type_(form_submitter_type.Submit)
        |> suggestion_chip.value("test")
        |> suggestion_chip.variant(chip_variant.Elevated),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    suggestion_chip.from_config(config)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_new_test() {
  let cases = [
    suggestion_chip.from_config(suggestion_chip.Config(
      disabled: suggestion_chip.IsNotDisabled,
      disabled_interactive: suggestion_chip.IsNotDisabledInteractive,
      download: None,
      href: "",
      name: "",
      rel: "",
      target: None,
      type_: form_submitter_type.Button,
      value: "",
      variant: chip_variant.Outlined,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    suggestion_chip.new()
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_disabled_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      suggestion_chip.IsDisabled,
      suggestion_chip.from_config(
        suggestion_chip.Config(
          ..suggestion_chip.default_config(),
          disabled: suggestion_chip.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_disabled_interactive_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      suggestion_chip.IsDisabledInteractive,
      suggestion_chip.from_config(
        suggestion_chip.Config(
          ..suggestion_chip.default_config(),
          disabled_interactive: suggestion_chip.IsDisabledInteractive,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.disabled_interactive(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_download_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      Some("test"),
      suggestion_chip.from_config(
        suggestion_chip.Config(
          ..suggestion_chip.default_config(),
          download: Some("test"),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.download(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_href_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      "test",
      suggestion_chip.from_config(
        suggestion_chip.Config(..suggestion_chip.default_config(), href: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.href(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_name_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      "test",
      suggestion_chip.from_config(
        suggestion_chip.Config(..suggestion_chip.default_config(), name: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_rel_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      "test",
      suggestion_chip.from_config(
        suggestion_chip.Config(..suggestion_chip.default_config(), rel: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.rel(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_target_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      Some(link_target.Self),
      suggestion_chip.from_config(
        suggestion_chip.Config(
          ..suggestion_chip.default_config(),
          target: Some(link_target.Self),
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.target(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_type__test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      form_submitter_type.Submit,
      suggestion_chip.from_config(
        suggestion_chip.Config(
          ..suggestion_chip.default_config(),
          type_: form_submitter_type.Submit,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.type_(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_value_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      "test",
      suggestion_chip.from_config(
        suggestion_chip.Config(
          ..suggestion_chip.default_config(),
          value: "test",
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_variant_test() {
  let mod = suggestion_chip.new()
  let cases = [
    #(
      chip_variant.Elevated,
      suggestion_chip.from_config(
        suggestion_chip.Config(
          ..suggestion_chip.default_config(),
          variant: chip_variant.Elevated,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    suggestion_chip.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_render_test() {
  let mod = suggestion_chip.new()

  let mod_disabled =
    suggestion_chip.new()
    |> suggestion_chip.disabled(suggestion_chip.IsDisabled)
  let mod_disabled_interactive =
    suggestion_chip.new()
    |> suggestion_chip.disabled_interactive(
      suggestion_chip.IsDisabledInteractive,
    )
  let mod_download =
    suggestion_chip.new() |> suggestion_chip.download(Some("test"))
  let mod_href = suggestion_chip.new() |> suggestion_chip.href("test")
  let mod_name = suggestion_chip.new() |> suggestion_chip.name("test")
  let mod_rel = suggestion_chip.new() |> suggestion_chip.rel("test")
  let mod_target =
    suggestion_chip.new() |> suggestion_chip.target(Some(link_target.Self))
  let mod_type_ =
    suggestion_chip.new() |> suggestion_chip.type_(form_submitter_type.Submit)
  let mod_value = suggestion_chip.new() |> suggestion_chip.value("test")
  let mod_variant =
    suggestion_chip.new() |> suggestion_chip.variant(chip_variant.Elevated)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-suggestion-chip", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-suggestion-chip", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-suggestion-chip", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a disabled_interactive attribute
    #(
      #(mod_disabled_interactive, [], []),
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("disabled-interactive", "")],
        [],
      ),
    ),
    // Happy path with a download attribute
    #(
      #(mod_download, [], []),
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("download", "test")],
        [],
      ),
    ),
    // Happy path with a href attribute
    #(
      #(mod_href, [], []),
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("href", "test")],
        [],
      ),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("name", "test")],
        [],
      ),
    ),
    // Happy path with a rel attribute
    #(
      #(mod_rel, [], []),
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("rel", "test")],
        [],
      ),
    ),
    // Happy path with a target attribute
    #(
      #(mod_target, [], []),
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("target", link_target.to_string(link_target.Self))],
        [],
      ),
    ),
    // Happy path with a type_ attribute
    #(
      #(mod_type_, [], []),
      element.element(
        "m3e-suggestion-chip",
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
      element.element(
        "m3e-suggestion-chip",
        [attribute.attribute("value", "test")],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-suggestion-chip",
        [
          attribute.attribute(
            "variant",
            chip_variant.to_string(chip_variant.Elevated),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    suggestion_chip.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn suggestion_chip_slot_test() {
  let cases = [
    #(suggestion_chip.Icon, attribute.attribute("slot", "icon")),
    #(
      suggestion_chip.TrailingIcon,
      attribute.attribute("slot", "trailing-icon"),
    ),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    suggestion_chip.slot(s)
    |> should.equal(expected)
  })
}
