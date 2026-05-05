//// update responds to messages from the user, and updates the model

import gleam/list
import gleam/result
import gleam/string

import lustre/effect.{type Effect}

import init
import model.{type Model, Model}
import msg.{type Msg}

import components/calendar_effects
import components/datepicker_effects

pub fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  case msg {
    msg.HomeSelected -> #(Model(..model, state: model.Home), effect.none())
    msg.AppBarPageSelected -> #(
      Model(..model, state: model.AppBar),
      effect.none(),
    )
    msg.ButtonSelected -> #(Model(..model, state: model.Button), effect.none())

    msg.CalendarSelected(id) -> #(
      Model(..model, state: model.Calendar),
      calendar_effects.attach_blackout_function(id),
    )

    msg.CalendarDateSelected(id) -> {
      #(model, calendar_effects.get_date(id))
    }

    msg.CalendarDateFetched(date) -> {
      let the_date =
        list.first(string.split(date, "T")) |> result.unwrap(init.initial_date)
      #(Model(..model, date_str: the_date), effect.none())
    }

    msg.CalendarBlackoutAttached -> #(model, effect.none())

    msg.DatepickerSelected(picker_id, input_id) -> #(
      Model(..model, state: model.Datepicker),
      datepicker_effects.attach_change_handler(picker_id, input_id),
    )

    msg.DatepickerReady -> #(model, effect.none())

    msg.IconPageSelected -> #(Model(..model, state: model.Icon), effect.none())

    msg.SwitchPageSelected -> #(
      Model(..model, state: model.Switch),
      effect.none(),
    )
  }
}
