// src/m3e/config.gleam

/// Dismissibility specifies if a component (like an Input Chip or Dialog)
/// presents a close button or 'X' to the user.
pub type Dismissibility {
  Dismissible
  NotDismissible
}

pub const default_dismissibility = NotDismissible

/// SelectionIndicator specifies if the visual markers (like a checkmark)
/// should be rendered when an item is in a Selected state.
pub type SelectionIndicator {
  ShowSelectionIndicator
  HideSelectionIndicator
}

pub const default_selection_indicator = ShowSelectionIndicator

/// SelectionMode specifies if a container (like a ChipSet or List)
/// allows only a single element to be active or multiple.
pub type SelectionMode {
  Single
  Multi
}

pub const default_selection_mode = Single
