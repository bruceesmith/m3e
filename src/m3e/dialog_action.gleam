//// dialog_action provides Lustre support for the M3E Dialog Action component

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

/// DialogAction holds the return value for a dialog action
/// 
/// ## Fields:
/// - return_value: The value to return from the dialog
/// 
pub opaque type DialogAction {
  DialogAction(return_value: String)
}

/// new creates a DialogAction
/// 
/// ## Parameters:
/// - return_value: The value to return from the dialog
/// 
pub fn new(return_value: String) -> DialogAction {
  DialogAction(return_value)
}

/// render creates a Lustre Element from a DialogAction
///
pub fn render(
  d: DialogAction,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-dialog-action",
    [attribute.attribute("return-value", d.return_value), ..attributes],
    children,
  )
}
