//// layout houses many functions which determine common styles across all showcase modules

import gleam/int

import lustre/attribute.{type Attribute}

import monks/align_items
import monks/display
import monks/gap
import monks/grid_column
import monks/grid_template_columns
import monks/justify_content
import monks/padding

/// card_style is the style for each Card on a single Frame
/// 
pub fn card_style() -> Attribute(msg) {
  attribute.styles([
    column(2),
    display.flex,
  ])
}

/// card_content_style is the style for each Card's content
/// 
pub fn card_content_style() -> Attribute(msg) {
  attribute.styles([
    align_items.center,
    display.flex,
    justify_content.flex_start,
    gap(5),
    pad(2),
  ])
}

/// column generates a CSS grid-column: <number>;
/// 
pub fn column(c: Int) -> #(String, String) {
  grid_column.raw(int.to_string(c))
}

/// frame_style is the style for each Frame
/// 
pub fn frame_style() -> Attribute(msg) {
  attribute.styles([
    align_items.center,
    display.grid,
    frcolumns(3),
    gap(5),
  ])
}

/// frcolumns generates a CSS grid-template-columns: repeat(<number>, 1fr);
/// 
pub fn frcolumns(number: Int) -> #(String, String) {
  grid_template_columns.raw("repeat(" <> int.to_string(number) <> ", 1fr)")
}

/// gap generates a CSS gap: calc(var(--spacing) * <number>);
/// 
pub fn gap(g: Int) -> #(String, String) {
  gap.raw("calc(var(--spacing) * " <> int.to_string(g) <> ")")
}

/// pad generates a CSS padding: calc(var(--spacing) * <number>);
/// 
pub fn pad(p: Int) -> #(String, String) {
  padding.raw("calc(var(--spacing) * " <> int.to_string(p) <> ")")
}
