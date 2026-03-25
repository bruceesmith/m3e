//// bottom_sheet_action provides Lustre support for the [M3E Bottom Sheet Action component](https://matraic.github.io/m3e/#/components/bottom-sheet.html)

import lustre/element.{type Element}

/// BottomSheetAction is an element, nested within a clickable element, used to close a parenting bottom sheet
/// 
/// ## Fields:
/// - label: the label of the action
/// 
pub opaque type BottomSheetAction {
  BottomSheetAction(label: String)
}

/// new creates a new BottomSheetAction
/// 
pub fn new() -> BottomSheetAction {
  BottomSheetAction(label: "")
}

/// label sets the label field of a BottomSheetAction
/// 
pub fn label(_: BottomSheetAction, label: String) -> BottomSheetAction {
  BottomSheetAction(label: label)
}

/// render creates a Lustre Element from a BottomSheetAction
///
pub fn render(b: BottomSheetAction) -> Element(msg) {
  element.element("m3e-bottom-sheet-action", [], [element.text(b.label)])
}
