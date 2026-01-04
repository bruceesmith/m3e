//// update responds to messages from the user, and updates the model

import lustre/effect.{type Effect}
import model.{type Model, Button, Home, Icon, Model, Switch}
import msg.{
  type Msg, ButtonPageSelected, HomeSelected, IconPageSelected,
  SwitchPageSelected,
}

pub fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    HomeSelected -> #(Model(state: Home), effect.none())
    ButtonPageSelected -> #(Model(state: Button), effect.none())
    IconPageSelected -> #(Model(state: Icon), effect.none())
    SwitchPageSelected -> #(Model(state: Switch), effect.none())
  }
}
