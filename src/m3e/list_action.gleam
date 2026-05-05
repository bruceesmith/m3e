//// ListAction is an item in a list that performs an action.
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

/// ListAction is a View Model for this component
///
/// ## Fields:
///
/// - disabled: Whether the element is disabled.
/// - download: A value indicating whether the `target` of the link button will be downloaded, optionally specifying the new name of the file.
/// - href: The URL to which the link button points.
/// - rel: The relationship between the `target` of the link button and the document.
/// - target: The target of the link button.
///
pub opaque type ListAction {
  ListAction(
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
  Leading
  // Renders the leading content of the list item.
  Overline
  // Renders the overline of the list item.
  SupportingText
  // Renders the supporting text of the list item.
  Trailing
  // Renders the trailing content of the list item.
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

/// from_config creates a new ListAction from the given configuration.
///
pub fn from_config(config: Config) -> ListAction {
  ListAction(
    disabled: config.disabled,
    download: config.download,
    href: config.href,
    rel: config.rel,
    target: config.target,
  )
}

/// new creates a new ListAction with the default configuration.
///
pub fn new() -> ListAction {
  from_config(default_config())
}

// --- Setters ---

/// disabled sets the value of disabled for this ListAction.
///
pub fn disabled(record: ListAction, disabled: Disabled) -> ListAction {
  ListAction(..record, disabled: disabled)
}

/// download sets the value of download for this ListAction.
///
pub fn download(record: ListAction, download: Option(String)) -> ListAction {
  ListAction(..record, download: download)
}

/// href sets the value of href for this ListAction.
///
pub fn href(record: ListAction, href: String) -> ListAction {
  ListAction(..record, href: href)
}

/// rel sets the value of rel for this ListAction.
///
pub fn rel(record: ListAction, rel: String) -> ListAction {
  ListAction(..record, rel: rel)
}

/// target sets the value of target for this ListAction.
///
pub fn target(record: ListAction, target: Option(LinkTarget)) -> ListAction {
  ListAction(..record, target: target)
}

// --- Renderers ---

/// render creates a Lustre Element for a ListAction
///
pub fn render(
  model: ListAction,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-list-action",
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

/// render_config creates a Lustre Element from a ListAction Config
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
    Leading -> attribute.attribute("slot", "leading")
    Overline -> attribute.attribute("slot", "overline")
    SupportingText -> attribute.attribute("slot", "supporting-text")
    Trailing -> attribute.attribute("slot", "trailing")
  }
}
