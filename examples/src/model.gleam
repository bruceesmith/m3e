//// model defines the Model for the demonstration SPA

pub type State {
  Home
  AppBar
  Button
  Calendar
  Icon
  Switch
}

pub type Model {
  Model(state: State)
}
