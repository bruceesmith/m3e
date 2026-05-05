//// NavItem is an item, placed in a navigation bar or rail, used to navigate to destinations in an application.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/function
import gleam/list
import gleam/option.{type Option, None}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/link_target.{type LinkTarget}
import m3e/nav_item_orientation.{type NavItemOrientation}

// --- Types ---

/// NavItem is a View Model for this component
///
/// ## Fields:
///
/// - disabled: A value indicating whether the element is disabled.
/// - disabled_interactive: A value indicating whether the element is disabled and interactive.
/// - download: A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file.
/// - href: The URL to which the link button points.
/// - orientation: The layout orientation of the item.
/// - rel: The relationship between the `target` of the link button and the document.
/// - selected: A value indicating whether the element is selected.
/// - target: The target of the link button.
///
pub opaque type NavItem {
  NavItem(
    disabled: Disabled,
    disabled_interactive: DisabledInteractive,
    download: Option(String),
    href: String,
    orientation: NavItemOrientation,
    rel: String,
    selected: Selected,
    target: Option(LinkTarget),
  )
}

/// Disabled is a value indicating whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

/// DisabledInteractive is a value indicating whether the element is disabled and interactive.
///
pub type DisabledInteractive {
  IsDisabledInteractive
  IsNotDisabledInteractive
}

/// Selected is a value indicating whether the element is selected.
///
pub type Selected {
  IsSelected
  IsNotSelected
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_disabled_interactive: DisabledInteractive = IsNotDisabledInteractive

pub const default_download: Option(String) = None

pub const default_href: String = ""

pub const default_orientation: NavItemOrientation = nav_item_orientation.Vertical

pub const default_rel: String = ""

pub const default_selected: Selected = IsNotSelected

pub const default_target: Option(LinkTarget) = None

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Icon
  // Renders the icon of the item.
  SelectedIcon
  // Renders the icon of the item when selected.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    disabled_interactive: DisabledInteractive,
    download: Option(String),
    href: String,
    orientation: NavItemOrientation,
    rel: String,
    selected: Selected,
    target: Option(LinkTarget),
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    disabled_interactive: IsNotDisabledInteractive,
    download: None,
    href: "",
    orientation: nav_item_orientation.Vertical,
    rel: "",
    selected: IsNotSelected,
    target: None,
  )
}

// --- Constructors ---

/// from_config creates a new NavItem from the given configuration.
///
pub fn from_config(config: Config) -> NavItem {
  NavItem(
    disabled: config.disabled,
    disabled_interactive: config.disabled_interactive,
    download: config.download,
    href: config.href,
    orientation: config.orientation,
    rel: config.rel,
    selected: config.selected,
    target: config.target,
  )
}

/// new creates a new NavItem with the default configuration.
///
pub fn new() -> NavItem {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this NavItem.
///
pub fn disabled(record: NavItem, disabled: Disabled) -> NavItem {
  NavItem(..record, disabled: disabled)
}

/// disabled_interactive sets the value of disabled_interactive for this NavItem.
///
pub fn disabled_interactive(
  record: NavItem,
  disabled_interactive: DisabledInteractive,
) -> NavItem {
  NavItem(..record, disabled_interactive: disabled_interactive)
}

/// download sets the value of download for this NavItem.
///
pub fn download(record: NavItem, download: Option(String)) -> NavItem {
  NavItem(..record, download: download)
}

/// href sets the value of href for this NavItem.
///
pub fn href(record: NavItem, href: String) -> NavItem {
  NavItem(..record, href: href)
}

/// orientation sets the value of orientation for this NavItem.
///
pub fn orientation(record: NavItem, orientation: NavItemOrientation) -> NavItem {
  NavItem(..record, orientation: orientation)
}

/// rel sets the value of rel for this NavItem.
///
pub fn rel(record: NavItem, rel: String) -> NavItem {
  NavItem(..record, rel: rel)
}

/// selected sets the value of selected for this NavItem.
///
pub fn selected(record: NavItem, selected: Selected) -> NavItem {
  NavItem(..record, selected: selected)
}

/// target sets the value of target for this NavItem.
///
pub fn target(record: NavItem, target: Option(LinkTarget)) -> NavItem {
  NavItem(..record, target: target)
}

// --- Renderers ---

/// render creates a Lustre Element for a NavItem
///
pub fn render(
  model: NavItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-nav-item",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.boolean(
          "disabled-interactive",
          model.disabled_interactive == IsDisabledInteractive,
        ),
        attr.option(
          model.download,
          fn(_) { "download" },
          function.identity,
          default_download,
        ),
        attr.with_default("href", model.href, default_href),
        attr.with_default(
          "orientation",
          nav_item_orientation.to_string(model.orientation),
          nav_item_orientation.to_string(default_orientation),
        ),
        attr.with_default("rel", model.rel, default_rel),
        attr.boolean("selected", model.selected == IsSelected),
        attr.option(
          model.target,
          fn(_) { "target" },
          link_target.to_string,
          default_target,
        ),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a NavItem Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}

/// slot returns a Lustre Attribute(msg) for the given slot name
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Icon -> attribute.attribute("slot", "icon")
    SelectedIcon -> attribute.attribute("slot", "selected-icon")
  }
}
