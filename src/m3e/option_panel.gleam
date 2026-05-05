//// OptionPanel is presents a list of options on a temporary surface.
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
import m3e/option_panel_state.{type OptionPanelState}

// --- Types ---

/// OptionPanel is a View Model for this component
///
/// ## Fields:
///
/// - state: The state for which to present content.
/// - scroll_strategy: The strategy that controls how the panel behaves when its trigger scrolls.
/// - fit_anchor_width: Whether the panel's width should match its anchor's width.
/// - anchor_offset: The logical margin, in pixels, between the panel and its anchor.
///
pub opaque type OptionPanel {
  OptionPanel(
    state: OptionPanelState,
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

pub const default_state: OptionPanelState = option_panel_state.Content

pub const default_scroll_strategy: FloatingPanelScrollStrategy = floating_panel_scroll_strategy.Hide

pub const default_fit_anchor_width: FitAnchorWidth = IsNotFitAnchorWidth

pub const default_anchor_offset: Float = 0.0

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    state: OptionPanelState,
    scroll_strategy: FloatingPanelScrollStrategy,
    fit_anchor_width: FitAnchorWidth,
    anchor_offset: Float,
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    state: option_panel_state.Content,
    scroll_strategy: floating_panel_scroll_strategy.Hide,
    fit_anchor_width: IsNotFitAnchorWidth,
    anchor_offset: 0.0,
  )
}

// --- Constructors ---

/// from_config creates a new OptionPanel from the given configuration.
///
pub fn from_config(config: Config) -> OptionPanel {
  OptionPanel(
    state: config.state,
    scroll_strategy: config.scroll_strategy,
    fit_anchor_width: config.fit_anchor_width,
    anchor_offset: config.anchor_offset,
  )
}

/// new creates a new OptionPanel with the default configuration.
///
pub fn new() -> OptionPanel {
  from_config(default_config())
}

// --- Setters ---

/// state sets the value of state for this OptionPanel.
///
pub fn state(record: OptionPanel, state: OptionPanelState) -> OptionPanel {
  OptionPanel(..record, state: state)
}

/// scroll_strategy sets the value of scroll_strategy for this OptionPanel.
///
pub fn scroll_strategy(
  record: OptionPanel,
  scroll_strategy: FloatingPanelScrollStrategy,
) -> OptionPanel {
  OptionPanel(..record, scroll_strategy: scroll_strategy)
}

/// fit_anchor_width sets the value of fit_anchor_width for this OptionPanel.
///
pub fn fit_anchor_width(
  record: OptionPanel,
  fit_anchor_width: FitAnchorWidth,
) -> OptionPanel {
  OptionPanel(..record, fit_anchor_width: fit_anchor_width)
}

/// anchor_offset sets the value of anchor_offset for this OptionPanel.
///
pub fn anchor_offset(record: OptionPanel, anchor_offset: Float) -> OptionPanel {
  OptionPanel(..record, anchor_offset: anchor_offset)
}

// --- Renderers ---

/// render creates a Lustre Element for a OptionPanel
///
pub fn render(
  model: OptionPanel,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-option-panel",
    list.flatten([
      [
        attr.with_default(
          "state",
          option_panel_state.to_string(model.state),
          option_panel_state.to_string(default_state),
        ),
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

/// render_config creates a Lustre Element from a OptionPanel Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}
