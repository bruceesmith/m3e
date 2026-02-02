//// model defines the Model for the demonstration SPA

pub type State {
  Home
  Button
  Icon
  Switch
}

pub type Model {
  Model(state: State)
}
