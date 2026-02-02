import gleam/string

import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element}
import lustre/element/html

import m3e/helpers.{boolean_attribute}

/// Mode is the behaviour of a drawer
/// 
pub type Mode {
  Auto
  Over
  Push
  Side
}

/// Convert a Mode to a string
/// 
fn mode_to_string(m: Mode) -> String {
  case m {
    Auto -> "auto"
    Over -> "over"
    Push -> "push"
    Side -> "side"
  }
}

/// Default Mode
/// 
pub const default_mode = Auto

/// Usage is whether a drawer is at the start or end, or is not used
/// 
pub type Usage {
  Start
  End
  Vacant
}

/// Drawer is the content of either the start or end drawer in a DrawerContainer
/// 
/// ## Fields:
/// - usage: whether the drawer is at the start or end, or is unused
/// - mode: the behaviour of the drawer
/// - open: whether the drawer is open
/// - id: the id of the drawer
/// - divider: whether to show a divider between the drawer and content for side mode
/// - content: the content of the drawer
///
pub opaque type Drawer(msg) {
  Drawer(
    usage: Usage,
    mode: Mode,
    open: Bool,
    id: String,
    divider: Bool,
    content: Element(msg),
  )
}

/// drawer creates a Drawer
/// 
/// ## Parameters:
/// - usage: whether the drawer is at the start or end, or is unused
/// - mode: the behaviour of the drawer
/// - open: whether the drawer is open
/// - id: the id of the drawer
/// - divider: whether to show a divider between the drawer and content for side mode
/// - content: the content of the drawer
/// 
/// ## Returns:
/// A Drawer
///
pub fn drawer(
  usage: Usage,
  mode: Mode,
  open: Bool,
  id: String,
  divider: Bool,
  content: Element(msg),
) -> Drawer(msg) {
  Drawer(
    usage: usage,
    mode: mode,
    open: open,
    id: id,
    divider: divider,
    content: content,
  )
}

/// empty returns an unused drawer
/// 
pub fn empty() -> Drawer(msg) {
  Drawer(Vacant, Auto, False, "", False, element.none())
}

/// divider sets the `divider` field
/// 
pub fn divider(c: Drawer(msg), divider: Bool) -> Drawer(msg) {
  Drawer(..c, divider: divider)
}

/// mode sets the `end_mode` field
/// 
pub fn mode(c: Drawer(msg), mode: Mode) -> Drawer(msg) {
  Drawer(..c, mode: mode)
}

/// usage sets the `usage` field
/// 
pub fn usage(c: Drawer(msg), usage: Usage) -> Drawer(msg) {
  Drawer(..c, usage: usage)
}

/// open sets the `open` field
/// 
pub fn open(c: Drawer(msg), open: Bool) -> Drawer(msg) {
  Drawer(..c, open: open)
}

/// toggle flips the `open` field
/// 
pub fn toggle(c: Drawer(msg)) -> Drawer(msg) {
  Drawer(..c, open: !c.open)
}

/// id sets the `id` field
/// 
pub fn id(c: Drawer(msg), id: String) -> Drawer(msg) {
  Drawer(..c, id: id)
}

/// content sets the `content` field
/// 
pub fn content(c: Drawer(msg), content: Element(msg)) -> Drawer(msg) {
  Drawer(..c, content: content)
}

/// element returns attributes for the enclosing DrawerContainer that are related to
/// this Drawer, plus the Element(msg) for the drawer itself
/// 
/// ## Parameters:
/// - dc: a Drawer
/// 
pub fn element(dc: Drawer(msg)) -> #(List(Attribute(msg)), Element(msg)) {
  let id = case string.length(dc.id) {
    0 -> none()
    _ -> attribute("id", dc.id)
  }
  let attributes = case dc.usage {
    Start -> [
      boolean_attribute("start", dc.open),
      boolean_attribute("start-divider", dc.divider),
      attribute("start-mode", mode_to_string(dc.mode)),
    ]
    End -> [
      boolean_attribute("end", dc.open),
      boolean_attribute("end-divider", dc.divider),
      attribute("end-mode", mode_to_string(dc.mode)),
    ]
    Vacant -> [none()]
  }

  let elt = case dc.usage {
    Start -> html.div([attribute("slot", "start"), id], [dc.content])
    End -> html.div([attribute("slot", "end"), id], [dc.content])
    Vacant -> element.none()
  }
  #(attributes, elt)
}
