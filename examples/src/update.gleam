//// update responds to messages from the user, and updates the model

import lustre/effect.{type Effect}
import model.{type Model, AppBar, Button, Home, Icon, Model, Switch}
import msg.{
  type Msg, AppBarPageSelected, ButtonPageSelected, HomeSelected,
  IconPageSelected, SwitchPageSelected,
}

pub fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    HomeSelected -> #(Model(state: Home), effect.none())
    AppBarPageSelected -> #(Model(state: AppBar), effect.none())
    ButtonPageSelected -> #(Model(state: Button), effect.none())
    IconPageSelected -> #(Model(state: Icon), effect.none())
    SwitchPageSelected -> #(Model(state: Switch), effect.none())
  }
}
