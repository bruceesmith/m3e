//// Card unit tests
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
import m3e/card.{Config}
import m3e/card_orientation
import m3e/card_variant
import m3e/form_submitter_type
import m3e/link_target

pub fn card_default_config_test() {
  let cases = [
    Config(
      actionable: card.IsNotActionable,
      inline: card.IsNotInline,
      orientation: card_orientation.Vertical,
      variant: card_variant.Filled,
      href: "",
      target: None,
      rel: "",
      download: None,
      name: "",
      value: "",
      type_: form_submitter_type.Button,
      disabled_interactive: card.IsNotDisabledInteractive,
      disabled: card.IsNotDisabled,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    card.default_config()
    |> should.equal(expected)
  })
}

pub fn card_from_config_test() {
  let cases = [
    #(
      card.Config(
        actionable: card.IsActionable,
        inline: card.IsInline,
        orientation: card_orientation.Horizontal,
        variant: card_variant.Elevated,
        href: "test",
        target: Some(link_target.Self),
        rel: "test",
        download: Some("test"),
        name: "test",
        value: "test",
        type_: form_submitter_type.Submit,
        disabled_interactive: card.IsDisabledInteractive,
        disabled: card.IsDisabled,
      ),
      card.new()
        |> card.actionable(card.IsActionable)
        |> card.inline(card.IsInline)
        |> card.orientation(card_orientation.Horizontal)
        |> card.variant(card_variant.Elevated)
        |> card.href("test")
        |> card.target(Some(link_target.Self))
        |> card.rel("test")
        |> card.download(Some("test"))
        |> card.name("test")
        |> card.value("test")
        |> card.type_(form_submitter_type.Submit)
        |> card.disabled_interactive(card.IsDisabledInteractive)
        |> card.disabled(card.IsDisabled),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    card.from_config(config)
    |> should.equal(expected)
  })
}

pub fn card_new_test() {
  let cases = [
    card.from_config(card.Config(
      actionable: card.IsNotActionable,
      inline: card.IsNotInline,
      orientation: card_orientation.Vertical,
      variant: card_variant.Filled,
      href: "",
      target: None,
      rel: "",
      download: None,
      name: "",
      value: "",
      type_: form_submitter_type.Button,
      disabled_interactive: card.IsNotDisabledInteractive,
      disabled: card.IsNotDisabled,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    card.new()
    |> should.equal(expected)
  })
}

pub fn card_actionable_test() {
  let mod = card.new()
  let cases = [
    #(
      card.IsActionable,
      card.from_config(
        card.Config(..card.default_config(), actionable: card.IsActionable),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.actionable(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_inline_test() {
  let mod = card.new()
  let cases = [
    #(
      card.IsInline,
      card.from_config(
        card.Config(..card.default_config(), inline: card.IsInline),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.inline(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_orientation_test() {
  let mod = card.new()
  let cases = [
    #(
      card_orientation.Horizontal,
      card.from_config(
        card.Config(
          ..card.default_config(),
          orientation: card_orientation.Horizontal,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.orientation(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_variant_test() {
  let mod = card.new()
  let cases = [
    #(
      card_variant.Elevated,
      card.from_config(
        card.Config(..card.default_config(), variant: card_variant.Elevated),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_href_test() {
  let mod = card.new()
  let cases = [
    #(
      "test",
      card.from_config(card.Config(..card.default_config(), href: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.href(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_target_test() {
  let mod = card.new()
  let cases = [
    #(
      Some(link_target.Self),
      card.from_config(
        card.Config(..card.default_config(), target: Some(link_target.Self)),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.target(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_rel_test() {
  let mod = card.new()
  let cases = [
    #(
      "test",
      card.from_config(card.Config(..card.default_config(), rel: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.rel(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_download_test() {
  let mod = card.new()
  let cases = [
    #(
      Some("test"),
      card.from_config(
        card.Config(..card.default_config(), download: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.download(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_name_test() {
  let mod = card.new()
  let cases = [
    #(
      "test",
      card.from_config(card.Config(..card.default_config(), name: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_value_test() {
  let mod = card.new()
  let cases = [
    #(
      "test",
      card.from_config(card.Config(..card.default_config(), value: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_type__test() {
  let mod = card.new()
  let cases = [
    #(
      form_submitter_type.Submit,
      card.from_config(
        card.Config(..card.default_config(), type_: form_submitter_type.Submit),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.type_(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_disabled_interactive_test() {
  let mod = card.new()
  let cases = [
    #(
      card.IsDisabledInteractive,
      card.from_config(
        card.Config(
          ..card.default_config(),
          disabled_interactive: card.IsDisabledInteractive,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.disabled_interactive(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_disabled_test() {
  let mod = card.new()
  let cases = [
    #(
      card.IsDisabled,
      card.from_config(
        card.Config(..card.default_config(), disabled: card.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    card.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn card_render_test() {
  let mod = card.new()

  let mod_actionable = card.new() |> card.actionable(card.IsActionable)
  let mod_inline = card.new() |> card.inline(card.IsInline)
  let mod_orientation =
    card.new() |> card.orientation(card_orientation.Horizontal)
  let mod_variant = card.new() |> card.variant(card_variant.Elevated)
  let mod_href = card.new() |> card.href("test")
  let mod_target = card.new() |> card.target(Some(link_target.Self))
  let mod_rel = card.new() |> card.rel("test")
  let mod_download = card.new() |> card.download(Some("test"))
  let mod_name = card.new() |> card.name("test")
  let mod_value = card.new() |> card.value("test")
  let mod_type_ = card.new() |> card.type_(form_submitter_type.Submit)
  let mod_disabled_interactive =
    card.new() |> card.disabled_interactive(card.IsDisabledInteractive)
  let mod_disabled = card.new() |> card.disabled(card.IsDisabled)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-card", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-card", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(#(mod, [], [html.br([])]), element.element("m3e-card", [], [html.br([])])),

    // Happy path with a actionable attribute
    #(
      #(mod_actionable, [], []),
      element.element("m3e-card", [attribute.attribute("actionable", "")], []),
    ),
    // Happy path with a inline attribute
    #(
      #(mod_inline, [], []),
      element.element("m3e-card", [attribute.attribute("inline", "")], []),
    ),
    // Happy path with a orientation attribute
    #(
      #(mod_orientation, [], []),
      element.element(
        "m3e-card",
        [
          attribute.attribute(
            "orientation",
            card_orientation.to_string(card_orientation.Horizontal),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-card",
        [
          attribute.attribute(
            "variant",
            card_variant.to_string(card_variant.Elevated),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a href attribute
    #(
      #(mod_href, [], []),
      element.element("m3e-card", [attribute.attribute("href", "test")], []),
    ),
    // Happy path with a target attribute
    #(
      #(mod_target, [], []),
      element.element(
        "m3e-card",
        [attribute.attribute("target", link_target.to_string(link_target.Self))],
        [],
      ),
    ),
    // Happy path with a rel attribute
    #(
      #(mod_rel, [], []),
      element.element("m3e-card", [attribute.attribute("rel", "test")], []),
    ),
    // Happy path with a download attribute
    #(
      #(mod_download, [], []),
      element.element("m3e-card", [attribute.attribute("download", "test")], []),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element("m3e-card", [attribute.attribute("name", "test")], []),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element("m3e-card", [attribute.attribute("value", "test")], []),
    ),
    // Happy path with a type_ attribute
    #(
      #(mod_type_, [], []),
      element.element(
        "m3e-card",
        [
          attribute.attribute(
            "type",
            form_submitter_type.to_string(form_submitter_type.Submit),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a disabled_interactive attribute
    #(
      #(mod_disabled_interactive, [], []),
      element.element(
        "m3e-card",
        [attribute.attribute("disabled-interactive", "")],
        [],
      ),
    ),
    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-card", [attribute.attribute("disabled", "")], []),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    card.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn card_slot_test() {
  let cases = [
    #(card.Header, attribute.attribute("slot", "header")),
    #(card.Content, attribute.attribute("slot", "content")),
    #(card.Actions, attribute.attribute("slot", "actions")),
    #(card.Footer, attribute.attribute("slot", "footer")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    card.slot(s)
    |> should.equal(expected)
  })
}
