//// msg defines the Msg type for the MVU architecture

pub type Msg {
  /// messages for change of displayed page
  HomeSelected
  AppBarPageSelected
  ButtonSelected
  CalendarSelected(String)
  DatepickerSelected(String, String)
  IconPageSelected
  SwitchPageSelected

  /// messages for calendar
  CalendarDateSelected(String)
  CalendarDateFetched(String)
  CalendarBlackoutAttached

  /// messages for datepicker
  DatepickerReady
}
