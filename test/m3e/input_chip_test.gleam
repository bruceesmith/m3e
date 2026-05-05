//// InputChip unit tests
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html
import m3e/chip_variant
import m3e/input_chip.{Config}

pub fn input_chip_default_config_test() {
  let cases = [
    Config(
      disabled: input_chip.IsNotDisabled,
      disabled_interactive: input_chip.IsNotDisabledInteractive,
      removable: input_chip.IsNotRemovable,
      remove_label: "Remove",
      value: "",
      variant: chip_variant.Outlined,
    ),
  ]

  list.each(cases, fn(c) {
    let expected = c

    input_chip.default_config()
    |> should.equal(expected)
  })
}

pub fn input_chip_from_config_test() {
  let cases = [
    #(
      input_chip.Config(
        disabled: input_chip.IsDisabled,
        disabled_interactive: input_chip.IsDisabledInteractive,
        removable: input_chip.IsRemovable,
        remove_label: "test",
        value: "test",
        variant: chip_variant.Elevated,
      ),
      input_chip.new()
        |> input_chip.disabled(input_chip.IsDisabled)
        |> input_chip.disabled_interactive(input_chip.IsDisabledInteractive)
        |> input_chip.removable(input_chip.IsRemovable)
        |> input_chip.remove_label("test")
        |> input_chip.value("test")
        |> input_chip.variant(chip_variant.Elevated),
    ),
  ]

  list.each(cases, fn(c) {
    let #(config, expected) = c

    input_chip.from_config(config)
    |> should.equal(expected)
  })
}

pub fn input_chip_new_test() {
  let cases = [
    input_chip.from_config(input_chip.Config(
      disabled: input_chip.IsNotDisabled,
      disabled_interactive: input_chip.IsNotDisabledInteractive,
      removable: input_chip.IsNotRemovable,
      remove_label: "Remove",
      value: "",
      variant: chip_variant.Outlined,
    )),
  ]

  list.each(cases, fn(c) {
    let expected = c

    input_chip.new()
    |> should.equal(expected)
  })
}

pub fn input_chip_disabled_test() {
  let mod = input_chip.new()
  let cases = [
    #(
      input_chip.IsDisabled,
      input_chip.from_config(
        input_chip.Config(
          ..input_chip.default_config(),
          disabled: input_chip.IsDisabled,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip.disabled(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_disabled_interactive_test() {
  let mod = input_chip.new()
  let cases = [
    #(
      input_chip.IsDisabledInteractive,
      input_chip.from_config(
        input_chip.Config(
          ..input_chip.default_config(),
          disabled_interactive: input_chip.IsDisabledInteractive,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip.disabled_interactive(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_removable_test() {
  let mod = input_chip.new()
  let cases = [
    #(
      input_chip.IsRemovable,
      input_chip.from_config(
        input_chip.Config(
          ..input_chip.default_config(),
          removable: input_chip.IsRemovable,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip.removable(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_remove_label_test() {
  let mod = input_chip.new()
  let cases = [
    #(
      "test",
      input_chip.from_config(
        input_chip.Config(..input_chip.default_config(), remove_label: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip.remove_label(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_value_test() {
  let mod = input_chip.new()
  let cases = [
    #(
      "test",
      input_chip.from_config(
        input_chip.Config(..input_chip.default_config(), value: "test"),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip.value(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_variant_test() {
  let mod = input_chip.new()
  let cases = [
    #(
      chip_variant.Elevated,
      input_chip.from_config(
        input_chip.Config(
          ..input_chip.default_config(),
          variant: chip_variant.Elevated,
        ),
      ),
    ),
  ]

  list.each(cases, fn(c) {
    let #(field, expected) = c

    input_chip.variant(mod, field)
    |> should.equal(expected)
  })
}

pub fn input_chip_render_test() {
  let mod = input_chip.new()

  let mod_disabled =
    input_chip.new() |> input_chip.disabled(input_chip.IsDisabled)
  let mod_disabled_interactive =
    input_chip.new()
    |> input_chip.disabled_interactive(input_chip.IsDisabledInteractive)
  let mod_removable =
    input_chip.new() |> input_chip.removable(input_chip.IsRemovable)
  let mod_remove_label = input_chip.new() |> input_chip.remove_label("test")
  let mod_value = input_chip.new() |> input_chip.value("test")
  let mod_variant =
    input_chip.new() |> input_chip.variant(chip_variant.Elevated)

  let cases = [
    // Happy path with no attributes nor children
    #(#(mod, [], []), element.element("m3e-input-chip", [], [])),
    // Happy path with no children
    #(
      #(mod, [attribute.id("id")], []),
      element.element("m3e-input-chip", [attribute.id("id")], []),
    ),
    // Happy path with no attributes
    #(
      #(mod, [], [html.br([])]),
      element.element("m3e-input-chip", [], [html.br([])]),
    ),

    // Happy path with a disabled attribute
    #(
      #(mod_disabled, [], []),
      element.element(
        "m3e-input-chip",
        [attribute.attribute("disabled", "")],
        [],
      ),
    ),
    // Happy path with a disabled_interactive attribute
    #(
      #(mod_disabled_interactive, [], []),
      element.element(
        "m3e-input-chip",
        [attribute.attribute("disabled-interactive", "")],
        [],
      ),
    ),
    // Happy path with a removable attribute
    #(
      #(mod_removable, [], []),
      element.element(
        "m3e-input-chip",
        [attribute.attribute("removable", "")],
        [],
      ),
    ),
    // Happy path with a remove_label attribute
    #(
      #(mod_remove_label, [], []),
      element.element(
        "m3e-input-chip",
        [attribute.attribute("remove-label", "test")],
        [],
      ),
    ),
    // Happy path with a value attribute
    #(
      #(mod_value, [], []),
      element.element(
        "m3e-input-chip",
        [attribute.attribute("value", "test")],
        [],
      ),
    ),
    // Happy path with a variant attribute
    #(
      #(mod_variant, [], []),
      element.element(
        "m3e-input-chip",
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

    input_chip.render(mod, attributes, children)
    |> should.equal(expected)
  })
}

pub fn input_chip_slot_test() {
  let cases = [
    #(input_chip.Avatar, attribute.attribute("slot", "avatar")),
    #(input_chip.Icon, attribute.attribute("slot", "icon")),
    #(input_chip.RemoveIcon, attribute.attribute("slot", "remove-icon")),
    #(input_chip.TrailingIcon, attribute.attribute("slot", "trailing-icon")),
  ]

  list.each(cases, fn(c) {
    let #(s, expected) = c

    input_chip.slot(s)
    |> should.equal(expected)
  })
}
