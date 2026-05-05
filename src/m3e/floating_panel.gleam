//// FloatingPanel is a lightweight, generic floating surface used to present content above the page.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/float
import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/floating_panel_scroll_strategy.{type FloatingPanelScrollStrategy}

// --- Types ---

/// FloatingPanel is a View Model for this component
///
/// ## Fields:
///
/// - scroll_strategy: The strategy that controls how the panel behaves when its trigger scrolls.
/// - fit_anchor_width: Whether the panel's width should match its anchor's width.
/// - anchor_offset: The logical margin, in pixels, between the panel and its anchor.
///
pub opaque type FloatingPanel {
  FloatingPanel(
    scroll_strategy: FloatingPanelScrollStrategy,
    fit_anchor_width: FitAnchorWidth,
    anchor_offset: Float,
  )
}

/// FitAnchorWidth is whether the panel's width should match its anchor's width.
///
pub type FitAnchorWidth {
  IsFitAnchorWidth
  IsNotFitAnchorWidth
}

// --- Defaults ---

pub const default_scroll_strategy: FloatingPanelScrollStrategy = floating_panel_scroll_strategy.Hide

pub const default_fit_anchor_width: FitAnchorWidth = IsNotFitAnchorWidth

pub const default_anchor_offset: Float = 0.0

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    scroll_strategy: FloatingPanelScrollStrategy,
    fit_anchor_width: FitAnchorWidth,
    anchor_offset: Float,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    scroll_strategy: floating_panel_scroll_strategy.Hide,
    fit_anchor_width: IsNotFitAnchorWidth,
    anchor_offset: 0.0,
  )
}

// --- Constructors ---

/// from_config creates a new FloatingPanel from the given configuration.
///
pub fn from_config(config: Config) -> FloatingPanel {
  FloatingPanel(
    scroll_strategy: config.scroll_strategy,
    fit_anchor_width: config.fit_anchor_width,
    anchor_offset: config.anchor_offset,
  )
}

/// new creates a new FloatingPanel with the default configuration.
///
pub fn new() -> FloatingPanel {
  from_config(default_config())
}

// --- Setters ---

/// scroll_strategy sets the value of scroll_strategy for this FloatingPanel.
///
pub fn scroll_strategy(
  record: FloatingPanel,
  scroll_strategy: FloatingPanelScrollStrategy,
) -> FloatingPanel {
  FloatingPanel(..record, scroll_strategy: scroll_strategy)
}

/// fit_anchor_width sets the value of fit_anchor_width for this FloatingPanel.
///
pub fn fit_anchor_width(
  record: FloatingPanel,
  fit_anchor_width: FitAnchorWidth,
) -> FloatingPanel {
  FloatingPanel(..record, fit_anchor_width: fit_anchor_width)
}

/// anchor_offset sets the value of anchor_offset for this FloatingPanel.
///
pub fn anchor_offset(
  record: FloatingPanel,
  anchor_offset: Float,
) -> FloatingPanel {
  FloatingPanel(..record, anchor_offset: anchor_offset)
}

// --- Renderers ---

/// render creates a Lustre Element for a FloatingPanel
///
pub fn render(
  model: FloatingPanel,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-floating-panel",
    list.flatten([
      [
        attr.with_default(
          "scroll-strategy",
          floating_panel_scroll_strategy.to_string(model.scroll_strategy),
          floating_panel_scroll_strategy.to_string(default_scroll_strategy),
        ),
        attr.boolean(
          "fit-anchor-width",
          model.fit_anchor_width == IsFitAnchorWidth,
        ),
        attr.with_default(
          "anchor-offset",
          float.to_string(model.anchor_offset),
          float.to_string(default_anchor_offset),
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a FloatingPanel Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}
