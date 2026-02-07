//// dialog_trigger provides Lustre support for the M3E Dialog Trigger component

import lustre/attribute.{type Attribute, for}
import lustre/element.{type Element, element}

/// Dialog Trigger component
/// 
/// ## Fields:
/// - for: The identifier of the interactive control to which this element is attached
/// 
pub opaque type DialogTrigger {
  DialogTrigger(for: String)
}

/// new creates a DialogTrigger
/// 
/// ## Parameters:
/// - for: The identifier of the interactive control to which this element is attached
/// 
pub fn new(for: String) -> DialogTrigger {
  DialogTrigger(for)
}

/// render creates a Lustre Element from a DialogTrigger
/// 
pub fn render(
  d: DialogTrigger,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element("m3e-dialog-trigger", [for(d.for), ..attributes], children)
}
