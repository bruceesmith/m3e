// src/m3e/gleam

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

/// Size is the size of an element, with 5 variations
/// 
pub type Size {
  ExtraSmall
  Small
  Medium
  Large
  ExtraLarge
}

/// clamp_to_restricted_size ensures that its input is one of the
/// restricted set of sizes (Large, Medium, or Small), returning
/// a default Size if not
/// 
pub fn clamp_to_restricted_size(input: Size, default: Size) -> Size {
  case input {
    Large | Medium | Small -> input
    ExtraLarge ->
      case default {
        Large | Medium | Small -> default
        ExtraLarge | ExtraSmall -> default_size
      }
    ExtraSmall ->
      case default {
        Large | Medium | Small -> default
        ExtraLarge | ExtraSmall -> default_size
      }
  }
}

pub fn size_to_string(s: Size) -> String {
  case s {
    ExtraSmall -> "extra-small"
    Small -> "small"
    Medium -> "medium"
    Large -> "large"
    ExtraLarge -> "extra-large"
  }
}

pub const default_size = Small
