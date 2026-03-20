// types provides a library-wide location for shared semantic enumerations

// pub const default_anchoring: AnchorPosition = AnchorAboveAfter

/// Interaction specifies if a chipset is enabled or disabled
/// 
pub type Interaction {
  Enabled
  Disabled
}

pub const default_interaction: Interaction = Enabled

/// Orientation specifies the layout orientation of the chipset
/// 
pub type Orientation {
  Horizontal
  Vertical
}

/// orientation_to_string converts an Orientation to a string
/// 
pub fn orientation_to_string(o: Orientation) -> String {
  case o {
    Horizontal -> "horizontal"
    Vertical -> "vertical"
  }
}

pub const default_orientation: Orientation = Horizontal

/// Requirement specifies if a selection is required
/// 
pub type Requirement {
  Required
  Optional
}

pub const default_requirement: Requirement = Optional

/// SelectionIndicator specifies if selection indicators should be hidden
/// 
pub type SelectionIndicator {
  ShowSelectionIndicator
  HideSelectionIndicator
}

pub const default_selection_indicator: SelectionIndicator = ShowSelectionIndicator
