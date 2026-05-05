//// Button unit tests
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
import m3e/button.{Config}
import m3e/button_shape
import m3e/button_size
import m3e/button_variant
import m3e/form_submitter_type
import m3e/link_target

pub fn button_default_config_test() {
  let cases = [
    Config(
      disabled: button.IsNotDisabled,
      disabled_interactive: button.IsNotDisabledInteractive,
      download: None,
      href: "",
      name: "",
      rel: "",
      selected: button.IsNotSelected,
      shape: button_shape.Rounded,
      size: button_size.Small,
      target: None,
      toggle: button.IsNotToggle,
      type_: form_submitter_type.Button,
      value: "",
      variant: button_variant.Text,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    button.default_config()
    |> should.equal(expected)
  })
}

pub fn button_from_config_test() {
  let cases = [
    #(
      button.Config(
        disabled: button.IsDisabled,
        disabled_interactive: button.IsDisabledInteractive,
        download: Some("test"),
        href: "test",
        name: "test",
        rel: "test",
        selected: button.IsSelected,
        shape: button_shape.Square,
        size: button_size.ExtraSmall,
        target: Some(link_target.Self),
        toggle: button.IsToggle,
        type_: form_submitter_type.Submit,
        value: "test",
        variant: button_variant.Elevated,
      ),
      button.new()
        |> button.disabled(button.IsDisabled)
        |> button.disabled_interactive(button.IsDisabledInteractive)
        |> button.download(Some("test"))
        |> button.href("test")
        |> button.name("test")
        |> button.rel("test")
        |> button.selected(button.IsSelected)
        |> button.shape(button_shape.Square)
        |> button.size(button_size.ExtraSmall)
        |> button.target(Some(link_target.Self))
        |> button.toggle(button.IsToggle)
        |> button.type_(form_submitter_type.Submit)
        |> button.value("test")
        |> button.variant(button_variant.Elevated),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    button.from_config(config)
    |> should.equal(expected)
  })
}

pub fn button_new_test() {
  let cases = [
    button.from_config(button.Config(
      disabled: button.IsNotDisabled,
      disabled_interactive: button.IsNotDisabledInteractive,
      download: None,
      href: "",
      name: "",
      rel: "",
      selected: button.IsNotSelected,
      shape: button_shape.Rounded,
      size: button_size.Small,
      target: None,
      toggle: button.IsNotToggle,
      type_: form_submitter_type.Button,
      value: "",
      variant: button_variant.Text,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    button.new()
    |> should.equal(expected)
  })
}

pub fn button_disabled_test() {
  let mod = button.new()
  let cases = [
    #(
      button.IsDisabled,
      button.from_config(
        button.Config(..button.default_config(), disabled: button.IsDisabled),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_disabled_interactive_test() {
  let mod = button.new()
  let cases = [
    #(
      button.IsDisabledInteractive,
      button.from_config(
        button.Config(
          ..button.default_config(),
          disabled_interactive: button.IsDisabledInteractive,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.disabled_interactive(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_download_test() {
  let mod = button.new()
  let cases = [
    #(
      Some("test"),
      button.from_config(
        button.Config(..button.default_config(), download: Some("test")),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.download(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_href_test() {
  let mod = button.new()
  let cases = [
    #(
      "test",
      button.from_config(button.Config(..button.default_config(), href: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.href(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_name_test() {
  let mod = button.new()
  let cases = [
    #(
      "test",
      button.from_config(button.Config(..button.default_config(), name: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.name(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_rel_test() {
  let mod = button.new()
  let cases = [
    #(
      "test",
      button.from_config(button.Config(..button.default_config(), rel: "test")),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.rel(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_selected_test() {
  let mod = button.new()
  let cases = [
    #(
      button.IsSelected,
      button.from_config(
        button.Config(..button.default_config(), selected: button.IsSelected),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.selected(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_shape_test() {
  let mod = button.new()
  let cases = [
    #(
      button_shape.Square,
      button.from_config(
        button.Config(..button.default_config(), shape: button_shape.Square),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.shape(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_size_test() {
  let mod = button.new()
  let cases = [
    #(
      button_size.ExtraSmall,
      button.from_config(
        button.Config(..button.default_config(), size: button_size.ExtraSmall),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.size(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_target_test() {
  let mod = button.new()
  let cases = [
    #(
      Some(link_target.Self),
      button.from_config(
        button.Config(..button.default_config(), target: Some(link_target.Self)),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.target(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_toggle_test() {
  let mod = button.new()
  let cases = [
    #(
      button.IsToggle,
      button.from_config(
        button.Config(..button.default_config(), toggle: button.IsToggle),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.toggle(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_type__test() {
  let mod = button.new()
  let cases = [
    #(
      form_submitter_type.Submit,
      button.from_config(
        button.Config(
          ..button.default_config(),
          type_: form_submitter_type.Submit,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.type_(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_value_test() {
  let mod = button.new()
  let cases = [
    #(
      "test",
      button.from_config(
        button.Config(..button.default_config(), value: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_variant_test() {
  let mod = button.new()
  let cases = [
    #(
      button_variant.Elevated,
      button.from_config(
        button.Config(
          ..button.default_config(),
          variant: button_variant.Elevated,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    button.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn button_render_test() {
  let mod = button.new()

  let mod_disabled = button.new() |> button.disabled(button.IsDisabled)
  let mod_disabled_interactive =
    button.new() |> button.disabled_interactive(button.IsDisabledInteractive)
  let mod_download = button.new() |> button.download(Some("test"))
  let mod_href = button.new() |> button.href("test")
  let mod_name = button.new() |> button.name("test")
  let mod_rel = button.new() |> button.rel("test")
  let mod_selected = button.new() |> button.selected(button.IsSelected)
  let mod_shape = button.new() |> button.shape(button_shape.Square)
  let mod_size = button.new() |> button.size(button_size.ExtraSmall)
  let mod_target = button.new() |> button.target(Some(link_target.Self))
  let mod_toggle = button.new() |> button.toggle(button.IsToggle)
  let mod_type_ = button.new() |> button.type_(form_submitter_type.Submit)
  let mod_value = button.new() |> button.value("test")
  let mod_variant = button.new() |> button.variant(button_variant.Elevated)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-button", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-button", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-button", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element("m3e-button", [attribute.attribute("disabled", "")], []),
    ),
    // Happy path with a disabled_interactive attribute
    #(
      #(mod_disabled_interactive, [], []),
      element.element(
        "m3e-button",
        [attribute.attribute("disabled-interactive", "")],
        [],
      ),
    ),
    // Happy path with a download attribute
    #(
      #(mod_download, [], []),
      element.element(
        "m3e-button",
        [attribute.attribute("download", "test")],
        [],
      ),
    ),
    // Happy path with a href attribute
    #(
      #(mod_href, [], []),
      element.element("m3e-button", [attribute.attribute("href", "test")], []),
    ),
    // Happy path with a name attribute
    #(
      #(mod_name, [], []),
      element.element("m3e-button", [attribute.attribute("name", "test")], []),
    ),
    // Happy path with a rel attribute
    #(
      #(mod_rel, [], []),
      element.element("m3e-button", [attribute.attribute("rel", "test")], []),
    ),
    // Happy path with a selected attribute
    #(
      #(mod_selected, [], []),
      element.element("m3e-button", [attribute.attribute("selected", "")], []),
    ),
    // Happy path with a shape attribute
    #(
      #(mod_shape, [], []),
      element.element(
        "m3e-button",
        [
          attribute.attribute(
            "shape",
            button_shape.to_string(button_shape.Square),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a size attribute
    #(
      #(mod_size, [], []),
      element.element(
        "m3e-button",
        [
          attribute.attribute(
            "size",
            button_size.to_string(button_size.ExtraSmall),
          ),
        ],
        [],
      ),
    ),
    // Happy path with a target attribute
    #(
      #(mod_target, [], []),
      element.element(
        "m3e-button",
        [attribute.attribute("target", link_target.to_string(link_target.Self))],
        [],
      ),
    ),
    // Happy path with a toggle attribute
    #(
      #(mod_toggle, [], []),
      element.element("m3e-button", [attribute.attribute("toggle", "")], []),
    ),
    // Happy path with a type_ attribute
    #(
      #(mod_type_, [], []),
      element.element(
        "m3e-button",
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
      element.element("m3e-button", [attribute.attribute("value", "test")], []),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-button",
        [
          attribute.attribute(
            "variant",
            button_variant.to_string(button_variant.Elevated),
          ),
        ],
        [],
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(#(mod, attributes, children), expected) = c

    button.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn button_slot_test() {
  let cases = [
    #(button.Icon, attribute.attribute("slot", "icon")),
    #(button.Selected, attribute.attribute("slot", "selected")),
    #(button.SelectedIcon, attribute.attribute("slot", "selected-icon")),
    #(button.TrailingIcon, attribute.attribute("slot", "trailing-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    button.slot(s)
    |> should.equal(expected)
  })
}
