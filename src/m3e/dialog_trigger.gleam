/// dialog_trigger is an element, nested within a clickable element, used to open a dialog
import lustre/attribute.{for}
import lustre/element.{type Element}

/// Dialog Trigger component
/// 
/// ## Fields:
/// - for: The identifier of the interactive control to which this element is attached
/// 
pub opaque type DialogTrigger {
  DialogTrigger(for: String)
}

/// dialog_trigger creates a DialogTrigger
/// 
/// ## Parameters:
/// - for: The identifier of the interactive control to which this element is attached
/// 
pub fn dialog_trigger(for: String) -> DialogTrigger {
  DialogTrigger(for)
}

/// element creates a Lustre Element from a DialogTrigger
pub fn element(d: DialogTrigger) -> Element(msg) {
  element.element("m3e-dialog-trigger", [for(d.for)], [])
}
