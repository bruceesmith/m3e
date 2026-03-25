//// textarea_autosize provides Lustre support for the [M3E Textarea Autosize component](https://matraic.github.io/m3e/#/components/textarea-autosize.html)

import gleam/int
import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/helpers
import m3e/state.{type Interaction, Disabled, Enabled}

// --- Types ---

pub const default_interaction = Enabled

/// TextareaAutosize provides Lustre support for the [M3E Textarea Autosize component](https://matraic.github.io/m3e/#/components/textarea-autosize.html)
/// 
/// ## Fields:
/// - disabled: Whether auto-sizing is disabled
/// - for: The identifier of the interactive control to which this element is attached
/// - max_rows: The maximum amount of rows in the `textarea`
/// - min_rows: The minimum amount of rows in the `textarea`
///
pub opaque type TextareaAutosize {
  TextareaAutosize(
    disabled: Interaction,
    for: String,
    max_rows: Int,
    min_rows: Int,
  )
}

// --- CONFIGURATION ---

/// Config holds the configuration for a TextareaAutosize
/// 
pub type Config {
  Config(disabled: Interaction, max_rows: Int, min_rows: Int)
}

/// default_config creates a new Config with default values
///
pub fn default_config() -> Config {
  Config(disabled: default_interaction, max_rows: 0, min_rows: 0)
}

// --- CONSTRUCTORS ---

/// new creates a new TextareaAutosize ,
/// 
pub fn new(for: String) -> TextareaAutosize {
  from_config(default_config(), for)
}

/// from_config creates a TextareaAutosize from a Config
///
pub fn from_config(config: Config, for: String) -> TextareaAutosize {
  TextareaAutosize(
    for: for,
    disabled: config.disabled,
    min_rows: config.min_rows,
    max_rows: config.max_rows,
  )
}

// --- SETTERS ---

/// disabled sets the disabled field
/// 
pub fn disabled(ta: TextareaAutosize, disabled: Interaction) -> TextareaAutosize {
  TextareaAutosize(..ta, disabled: disabled)
}

/// for sets the for field
/// 
pub fn for(ta: TextareaAutosize, for: String) -> TextareaAutosize {
  TextareaAutosize(..ta, for: for)
}

/// max_rows sets the max_rows field
///
pub fn max_rows(ta: TextareaAutosize, max_rows: Int) -> TextareaAutosize {
  TextareaAutosize(..ta, max_rows: max_rows)
}

/// min_rows sets the min_rows field
///
pub fn min_rows(ta: TextareaAutosize, min_rows: Int) -> TextareaAutosize {
  TextareaAutosize(..ta, min_rows: min_rows)
}

/// render creates a Lustre Element(msg) from a TextareaAutosize
///
/// ## Parameters:
/// - ta: a TextareaAutosize
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  ta: TextareaAutosize,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-textarea-autosize",
    list.flatten([
      [
        attribute.attribute("for", ta.for),
        helpers.boolean_attribute("disabled", ta.disabled == Disabled),
        attribute.attribute("max-rows", int.to_string(ta.max_rows)),
        attribute.attribute("min-rows", int.to_string(ta.min_rows)),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
pub fn render_config(
  config: Config,
  f: String,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(config, f), attributes, children)
}
