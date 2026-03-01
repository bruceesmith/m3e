//// tab_panel provides Lustre support for the [M3E Tab Panel component](https://matraic.github.io/m3e/#/components/tabs.html)

import gleam/list.{filter, flatten}
import lustre/attribute.{type Attribute, attribute, none}
import lustre/element.{type Element, element}

/// TabPanel provides Lustre support for the [M3E TabPanel component](https://matraic.github.io/m3e/#/components/tab-panel.html)
///
/// ## Fields:
/// - id: The identifier of the panel
/// 
pub opaque type TabPanel {
  TabPanel(id: String)
}

/// new creates a new TabPanel
/// 
pub fn new(id: String) -> TabPanel {
  TabPanel(id: id)
}

/// id sets the id field
/// 
pub fn id(_tp: TabPanel, id: String) -> TabPanel {
  TabPanel(id: id)
}

/// render creates a Lustre Element(msg) from a TabPanel
/// 
/// ## Parameters:
/// - tp: a TabPanel
/// - attributes: additional attributes
/// - children: additional children
///
pub fn render(
  tp: TabPanel,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element(
    "m3e-tab-panel",
    flatten([
      [
        attribute("id", tp.id),
      ],
      attributes,
    ])
      |> filter(fn(a) { a != none() }),
    children,
  )
}
