import gleam/option.{None, Some}
import gleeunit/should
import lustre/attribute
import lustre/element
import lustre/element/html

import m3e/button.{Config, Elevated, Filled, Outlined, Square, Text}
import m3e/config
import m3e/form_submission.{FormSubmission, Submit}
import m3e/state.{Disabled, Selected}

pub fn button_creation_test() {
  let b = button.new("Click me", Text)
  let expected_basic =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "text"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [element.text("Click me")],
    )
  button.render(b, []) |> should.equal(expected_basic)

  let b_full =
    button.new("Full", Filled)
    |> button.shape(Square)
    |> button.size(config.Large)
    |> button.selected_label("Selected")
    |> button.toggle(True)
    |> button.selected(Selected)
    |> button.disabled(Disabled)
    |> button.form(Some(FormSubmission(Submit, "key", "val")))

  let expected_full =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "filled"),
        attribute.attribute("shape", "square"),
        attribute.attribute("size", "large"),
        attribute.attribute("toggle", ""),
        attribute.selected(True),
        attribute.disabled(True),
        attribute.attribute("type", "submit"),
        attribute.attribute("name", "key"),
        attribute.attribute("value", "val"),
      ],
      [
        element.text("Full"),
        html.span([attribute.attribute("slot", "selected")], [
          element.text("Selected"),
        ]),
      ],
    )
  button.render(b_full, []) |> should.equal(expected_full)
}

pub fn button_element_test() {
  let b = button.new("Basic", Text)
  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "text"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [element.text("Basic")],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn config_test() {
  let config =
    Config(
      disabled: Disabled,
      disabled_interactive: Disabled,
      form_submission: Some(FormSubmission(Submit, "k", "v")),
      icons: [],
      label: "Configured",
      link: None,
      selected: Selected,
      selected_label: None,
      shape: Some(Square),
      size: Some(config.Large),
      toggle: True,
      variant: Some(Filled),
    )

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.disabled(True),
        attribute.attribute("disabled-interactive", ""),
        attribute.selected(True),
        attribute.attribute("shape", "square"),
        attribute.attribute("size", "large"),
        attribute.attribute("toggle", ""),
        attribute.attribute("variant", "filled"),
        attribute.attribute("type", "submit"),
        attribute.attribute("name", "k"),
        attribute.attribute("value", "v"),
      ],
      [element.text("Configured")],
    )
  button.render_config(config, []) |> should.equal(expected)
}

pub fn button_form_test() {
  let b =
    button.new("Submit", Filled)
    |> button.form(Some(FormSubmission(Submit, "k", "v")))

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "filled"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
        attribute.attribute("type", "submit"),
        attribute.name("k"),
        attribute.attribute("value", "v"),
      ],
      [element.text("Submit")],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn button_selected_label_test() {
  let b = button.new("Toggle", Outlined) |> button.selected_label("On")

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "outlined"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [
        element.text("Toggle"),
        html.span([attribute.attribute("slot", "selected")], [
          element.text("On"),
        ]),
      ],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn button_shape_test() {
  let b = button.new("Shape", Text) |> button.shape(Square)

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "text"),
        attribute.attribute("shape", "square"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [element.text("Shape")],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn button_size_test() {
  let b = button.new("Size", Text) |> button.size(config.Large)

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "text"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "large"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [element.text("Size")],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn button_variant_test() {
  let b = button.new("Variant", Text) |> button.variant(Elevated)

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "elevated"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [element.text("Variant")],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn button_icons_test() {
  let icon = html.span([], [element.text("icon")])
  let b = button.new("Icon", Text) |> button.icons([icon])

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "text"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [icon, element.text("Icon")],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn button_label_test() {
  let b = button.new("Original", Text) |> button.label("New Label")

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "text"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [element.text("New Label")],
    )
  b |> button.render([]) |> should.equal(expected)
}

pub fn button_toggle_test() {
  let b = button.new("Toggle Me", Text) |> button.toggle(True)

  let expected =
    element.element(
      "m3e-button",
      [
        attribute.attribute("variant", "text"),
        attribute.attribute("shape", "rounded"),
        attribute.attribute("size", "small"),
        attribute.attribute("toggle", ""),
        attribute.selected(False),
        attribute.disabled(False),
      ],
      [element.text("Toggle Me")],
    )
  b |> button.render([]) |> should.equal(expected)
}
