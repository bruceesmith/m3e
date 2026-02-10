import gleam/list
import gleam/option.{type Option, Some}

import lustre/attribute.{type Attribute, attribute}

import m3e/helpers.{boolean_attribute}

/// Target specifies where to open a linked document or display a form response
/// 
pub type Target {
  Blank
  Parent
  Self
  Top
}

pub fn link_target_to_string(t: Target) -> String {
  case t {
    Blank -> "_blank"
    Parent -> "_parent"
    Self -> "_self"
    Top -> "_top"
  }
}

/// Link defines all the attributes of an HTML link
///
/// ## Fields:
/// - download: Specifies that the target will be downloaded when a user clicks on the hyperlink
/// - href: Specifies the URL of the page the link goes to
/// - rel: Specifies the relationship between the current document and the linked document
/// - target: Specifies the target for where to open the linked document or where to submit the form
/// 
pub type Link {
  Link(download: Bool, href: String, rel: String, target: Target)
}

/// new creates a new Link
///
pub fn new(href: String) -> Link {
  Link(False, href, "", Self)
}

/// attributes creates Lustre Attributes for a Link
/// 
pub fn attributes(l: Option(Link)) -> List(Attribute(msg)) {
  case l {
    Some(link) if link.href != "" -> [
      boolean_attribute("download", link.download),
      attribute("href", link.href),
      case link.rel != "" {
        True -> attribute("rel", link.rel)
        False -> attribute.none()
      },
      attribute("rel", link.rel),
      attribute("target", link_target_to_string(link.target)),
    ]
    _ -> [attribute.none()]
  }
  |> list.filter(fn(a) { a != attribute.none() })
}

/// download updates the download attribute of a Link
///
pub fn download(link: Link, download: Bool) -> Link {
  Link(..link, download: download)
}

/// href updates the href attribute of a Link
///
pub fn href(link: Link, href: String) -> Link {
  Link(..link, href: href)
}

/// rel updates the rel attribute of a Link
///
pub fn rel(link: Link, rel: String) -> Link {
  Link(..link, rel: rel)
}

/// target updates the target attribute of a Link
///
pub fn target(link: Link, target: Target) -> Link {
  Link(..link, target: target)
}
