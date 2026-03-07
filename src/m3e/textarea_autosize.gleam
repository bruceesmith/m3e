//// textarea_autosize provides Lustre support for the [M3E Textarea Autosize component](https://matraic.github.io/m3e/#/components/textarea-autosize.html)

import gleam/int.{to_string}
import gleam/list.{filter, flatten}

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

import m3e/helpers.{boolean_attribute}

//  * @attr disabled - Whether auto-sizing is disabled.
//  * @attr for - The identifier of the interactive control to which this element is attached.
//  * @attr max-rows - The maximum amount of rows in the `textarea`.
//  * @attr min-rows - The minimum amount of rows in the `textarea`.

/// TextareaAutosize provides Lustre support for the [M3E Textarea Autosize component](https://matraic.github.io/m3e/#/components/textarea-autosize.html)
/// 
/// ## Fields:
/// - disabled: Whether auto-sizing is disabled
/// - for: The identifier of the interactive control to which this element is attached
/// - max_rows: The maximum amount of rows in the `textarea`
/// - min_rows: The minimum amount of rows in the `textarea`
///
pub opaque type TextareaAutosize {
  TextareaAutosize(disabled: Bool, for: String, max_rows: Int, min_rows: Int)
}

/// new creates a new TextareaAutosize 
/// 
pub fn new(for: String) -> TextareaAutosize {
  TextareaAutosize(for: for, disabled: False, min_rows: 0, max_rows: 0)
}

/// disabled sets the disabled field
/// 
pub fn disabled(ta: TextareaAutosize, disabled: Bool) -> TextareaAutosize {
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
  element(
    "m3e-textarea-autosize",
    flatten([
      [
        attribute("for", ta.for),
        boolean_attribute("disabled", ta.disabled),
        attribute("max-rows", to_string(ta.max_rows)),
        attribute("min-rows", to_string(ta.min_rows)),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}
