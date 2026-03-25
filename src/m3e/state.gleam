/// CheckedState specifies if a checkbox or toggle-able element 
/// is checked or unchecked.
pub type CheckedState {
  Checked
  Unchecked
}

pub const default_checked_state = Unchecked

/// SelectionState specifies if an element (like a Chip or List Item)
/// is currently selected or not.
pub type SelectionState {
  Selected
  Unselected
}

pub const default_selection_state = Unselected

/// Interaction specifies if a component or group of components
/// is interactive (Enabled) or non-responsive (Disabled).
pub type Interaction {
  Enabled
  Disabled
}

pub const default_interaction = Enabled

/// Requirement specifies if a form field or selection 
/// must be completed by the user.
pub type Requirement {
  Required
  Optional
}

pub const default_requirement = Optional
