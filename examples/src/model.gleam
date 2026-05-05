//// model defines the Model for the demonstration SPA

pub type State {
  Home
  AppBar
  Button
  Calendar
  Datepicker
  Icon
  Switch
}

pub type Model {
  Model(date_str: String, state: State)
}
