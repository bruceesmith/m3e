//// update responds to messages from the user, and updates the model

import lustre/effect.{type Effect}
import model.{type Model, Model}
import msg.{type Msg}

pub fn update(_model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    msg.HomeSelected -> #(Model(state: model.Home), effect.none())
    msg.AppBarPageSelected -> #(Model(state: model.AppBar), effect.none())
    msg.ButtonSelected -> #(Model(state: model.Button), effect.none())
    msg.CalendarSelected -> #(Model(state: model.Calendar), effect.none())
    msg.IconPageSelected -> #(Model(state: model.Icon), effect.none())
    msg.SwitchPageSelected -> #(Model(state: model.Switch), effect.none())
  }
}
