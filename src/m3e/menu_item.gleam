//// MenuItem is an item of a menu.
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

// --- Types ---

/// MenuItem is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - download: Whether the `target` of the link button will be downloaded, optionally specifying the new name of the file.
/// - href: The URL to which the link button points.
/// - rel: The relationship between the `target` of the link button and the document.
/// - target: The target of the link button.
///
pub opaque type MenuItem {
  MenuItem(
    disabled: Disabled,
    download: Option(String),
    href: String,
    rel: String,
    target: Option(LinkTarget),
  )
}

/// Disabled is whether the element is disabled.
///
pub type Disabled {
  IsDisabled
  IsNotDisabled
}

// --- Defaults ---

pub const default_disabled: Disabled = IsNotDisabled

pub const default_download: Option(String) = None

pub const default_href: String = ""

pub const default_rel: String = ""

pub const default_target: Option(LinkTarget) = None

/// Slots are used in child elements to insert content into this component
///
pub type Slot {
  Icon
  // Renders an icon before the items's label.
  TrailingIcon
  // Renders an icon after the item's label.
}

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(
    disabled: Disabled,
    download: Option(String),
    href: String,
    rel: String,
    target: Option(LinkTarget),
  )
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    disabled: IsNotDisabled,
    download: None,
    href: "",
    rel: "",
    target: None,
  )
}

// --- Constructors ---

/// from_config creates a new MenuItem from the given configuration.
///
pub fn from_config(config: Config) -> MenuItem {
  MenuItem(
    disabled: config.disabled,
    download: config.download,
    href: config.href,
    rel: config.rel,
    target: config.target,
  )
}

/// new creates a new MenuItem with the default configuration.
///
pub fn new() -> MenuItem {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this MenuItem.
///
pub fn disabled(record: MenuItem, disabled: Disabled) -> MenuItem {
  MenuItem(..record, disabled: disabled)
}

/// download sets the value of download for this MenuItem.
///
pub fn download(record: MenuItem, download: Option(String)) -> MenuItem {
  MenuItem(..record, download: download)
}

/// href sets the value of href for this MenuItem.
///
pub fn href(record: MenuItem, href: String) -> MenuItem {
  MenuItem(..record, href: href)
}

/// rel sets the value of rel for this MenuItem.
///
pub fn rel(record: MenuItem, rel: String) -> MenuItem {
  MenuItem(..record, rel: rel)
}

/// target sets the value of target for this MenuItem.
///
pub fn target(record: MenuItem, target: Option(LinkTarget)) -> MenuItem {
  MenuItem(..record, target: target)
}

// --- Renderers ---

/// render creates a Lustre Element for a MenuItem
///
pub fn render(
  model: MenuItem,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-menu-item",
    list.flatten([
      [
        attr.boolean("disabled", model.disabled == IsDisabled),
        attr.option(
          model.download,
          fn(_) { "download" },
          function.identity,
          default_download,
        ),
        attr.with_default("href", model.href, default_href),
        attr.with_default("rel", model.rel, default_rel),
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

/// render_config creates a Lustre Element from a MenuItem Config
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
    TrailingIcon -> attribute.attribute("slot", "trailing-icon")
  }
}
