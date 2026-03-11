import lustre/attribute.{type Attribute, attribute}

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  ExpandableListItemItems
  // Container for child list items displayed when expanded 
  ExpandableListItemLeading
  // Renders the leading content of the list item 
  ExpandableListItemOverline
  // Renders the overline of the list item 
  ExpandableListItemSupportingText
  // Renders the supporting text of the list item 
  ExpandableListItemToggleIcon
  // Renders a custom icon for the expand/collapse toggle 
  ExpandableListItemTrailing
  // This component does not expose the base trailing slot 
  ExpansionHeaderToggleIcon
  // Renders the icon of the expansion toggle 
  ListActionLeading
  // Renders the leading content of the list item 
  ListActionOverline
  // Renders the overline of the list item 
  ListActionSupportingText
  // Renders the supporting text of the list item 
  ListActionTrailing
  // Renders the trailing content of the list item 
  ListItemLeading
  // Renders the leading content of the list item 
  ListItemOverline
  // Renders the overline of the list item 
  ListItemSupportingText
  // Renders the supporting text of the list item
  ListItemTrailing
  // Renders the trailing content of the list item 
  ListOptionLeading
  // Renders the leading content of the list item 
  ListOptionOverline
  // Renders the overline of the list item 
  ListOptionSupportingText
  // Renders the supporting text of the list item 
  ListOptionTrailing
  // Renders the trailing content of the list item   
  RichTooltipActions
  // Optional action elements displayed at the bottom of the tooltip 
  RichTooltipSubhead
  // Optional subhead text displayed above the supporting content 
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    ExpandableListItemItems -> attribute("slot", "items")
    ExpandableListItemLeading -> attribute("slot", "leading")
    ExpandableListItemOverline -> attribute("slot", "overline")
    ExpandableListItemSupportingText -> attribute("slot", "supporting-text")
    ExpandableListItemToggleIcon -> attribute("slot", "toggle-icon")
    ExpandableListItemTrailing -> attribute("slot", "trailing")
    ExpansionHeaderToggleIcon -> attribute("slot", "toggle-icon")
    ListActionLeading -> attribute("slot", "leading")
    ListActionOverline -> attribute("slot", "overline")
    ListActionSupportingText -> attribute("slot", "supporting-text")
    ListActionTrailing -> attribute("slot", "trailing")
    ListItemLeading -> attribute("slot", "leading")
    ListItemOverline -> attribute("slot", "overline")
    ListItemSupportingText -> attribute("slot", "supporting-text")
    ListItemTrailing -> attribute("slot", "trailing")
    ListOptionLeading -> attribute("slot", "leading")
    ListOptionOverline -> attribute("slot", "overline")
    ListOptionSupportingText -> attribute("slot", "supporting-text")
    ListOptionTrailing -> attribute("slot", "trailing")
    RichTooltipActions -> attribute("slot", "actions")
    RichTooltipSubhead -> attribute("slot", "subhead")
  }
}
