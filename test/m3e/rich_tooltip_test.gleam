import gleeunit/should
import lustre/attribute
import lustre/element
import m3e/rich_tooltip
import m3e/types.{Disabled, Enabled}

// --- CONFIGURATION ---

pub fn default_config_test() {
  rich_tooltip.default_config()
  |> should.equal(rich_tooltip.Config(
    interaction: Enabled,
    for: "",
    hide_delay: 1500,
    position: rich_tooltip.Below,
    show_delay: 0,
  ))
}

// --- CONSTRUCTORS ---

pub fn new_test() {
  rich_tooltip.new()
  |> rich_tooltip.render([], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [
        attribute.attribute("for", ""),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [],
    ),
  )
}

pub fn from_config_test() {
  let config = rich_tooltip.default_config()
  rich_tooltip.from_config(config)
  |> rich_tooltip.render([], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [
        attribute.attribute("for", ""),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [],
    ),
  )
}

// --- SETTERS ---

pub fn disabled_test() {
  rich_tooltip.new()
  |> rich_tooltip.disabled(Disabled)
  |> rich_tooltip.render([], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("for", ""),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [],
    ),
  )
}

pub fn for_test() {
  rich_tooltip.new()
  |> rich_tooltip.for("my-id")
  |> rich_tooltip.render([], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [
        attribute.attribute("for", "my-id"),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [],
    ),
  )
}

pub fn hide_delay_test() {
  rich_tooltip.new()
  |> rich_tooltip.hide_delay(500)
  |> rich_tooltip.render([], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [
        attribute.attribute("for", ""),
        attribute.attribute("hide-delay", "500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "0"),
      ],
      [],
    ),
  )
}

pub fn show_delay_test() {
  rich_tooltip.new()
  |> rich_tooltip.show_delay(250)
  |> rich_tooltip.render([], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [
        attribute.attribute("for", ""),
        attribute.attribute("hide-delay", "1500"),
        attribute.attribute("position", "below"),
        attribute.attribute("show-delay", "250"),
      ],
      [],
    ),
  )
}

// --- RENDERING ---

pub fn render_test() {
  let attrs = [attribute.class("custom-class")]
  let children = [element.text("content")]

  rich_tooltip.new()
  |> rich_tooltip.disabled(Disabled)
  |> rich_tooltip.for("test-id")
  |> rich_tooltip.position(rich_tooltip.Above)
  |> rich_tooltip.render(attrs, children)
  |> should.equal(element.element(
    "m3e-rich-tooltip",
    [
      attribute.attribute("disabled", ""),
      attribute.attribute("for", "test-id"),
      attribute.attribute("hide-delay", "1500"),
      attribute.attribute("position", "above"),
      attribute.attribute("show-delay", "0"),
      attribute.class("custom-class"),
    ],
    children,
  ))
}

pub fn render_config_test() {
  let config =
    rich_tooltip.Config(
      interaction: Disabled,
      for: "config-id",
      hide_delay: 100,
      position: rich_tooltip.Before,
      show_delay: 200,
    )
  rich_tooltip.render_config(config, [], [])
  |> should.equal(
    element.element(
      "m3e-rich-tooltip",
      [
        attribute.attribute("disabled", ""),
        attribute.attribute("for", "config-id"),
        attribute.attribute("hide-delay", "100"),
        attribute.attribute("position", "before"),
        attribute.attribute("show-delay", "200"),
      ],
      [],
    ),
  )
}

pub fn all_positions_test() {
  let test_pos = fn(p, s) {
    rich_tooltip.new()
    |> rich_tooltip.position(p)
    |> rich_tooltip.render([], [])
    |> should.equal(
      element.element(
        "m3e-rich-tooltip",
        [
          attribute.attribute("for", ""),
          attribute.attribute("hide-delay", "1500"),
          attribute.attribute("position", s),
          attribute.attribute("show-delay", "0"),
        ],
        [],
      ),
    )
  }

  test_pos(rich_tooltip.AboveAfter, "above-after")
  test_pos(rich_tooltip.AboveBefore, "above-before")
  test_pos(rich_tooltip.BelowBefore, "below-before")
  test_pos(rich_tooltip.BelowAfter, "below-after")
  test_pos(rich_tooltip.Before, "before")
  test_pos(rich_tooltip.After, "after")
  test_pos(rich_tooltip.Above, "above")
  test_pos(rich_tooltip.Below, "below")
}

pub fn slot_test() {
  rich_tooltip.slot(rich_tooltip.Actions)
  |> should.equal(attribute.attribute("slot", "actions"))

  rich_tooltip.slot(rich_tooltip.Subhead)
  |> should.equal(attribute.attribute("slot", "subhead"))
}
