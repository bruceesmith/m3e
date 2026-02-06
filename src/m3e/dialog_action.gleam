/// dialog_action is an element, nested within a clickable element, used to close a parenting dialog
import lustre/attribute.{attribute}
import lustre/element.{type Element}

/// Dialog Action component
/// 
/// ## Fields:
/// - return_value: The return value of the dialog action
/// 
pub opaque type DialogAction {
  DialogAction(return_value: String)
}

/// dialog_action creates a DialogAction
/// 
/// ## Fields:
/// - return_value: The return value of the dialog action
/// 
pub fn dialog_action(return_value: String) -> DialogAction {
  DialogAction(return_value)
}

/// render creates a Lustre Element from a DialogAction
///
pub fn render(d: DialogAction) -> Element(msg) {
  element.element(
    "m3e-dialog-action",
    [attribute("return-value", d.return_value)],
    [],
  )
}
