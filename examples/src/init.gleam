//// Module init contains the functions for SPA initialisation 

import lustre/effect.{type Effect}
import model.{type Model, Home, Model}
import msg.{type Msg}

/// init is called by Model-View-Update at application initialisation. It establishes
/// the initial Model record
///
pub fn init(_args) -> #(Model, Effect(Msg)) {
  #(Model(state: Home), effect.none())
}
