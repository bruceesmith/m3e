import lustre/effect.{type Effect}

import msg.{type Msg}

/// Effect to attach the change handler to a date picker
///
@internal
pub fn attach_change_handler(picker_id: String, input_id: String) -> Effect(Msg) {
  effect.after_paint(fn(dispatch, _root) {
    attach_handler(picker_id, input_id)
    dispatch(msg.DatepickerReady)
  })
}

/// Interface to the JavaScript function that attaches the change handler to the date picker
///
@external(javascript, "./datepicker.ffi.mjs", "attach_change_handler")
fn attach_handler(_: String, _: String) -> Nil {
  Nil
}
