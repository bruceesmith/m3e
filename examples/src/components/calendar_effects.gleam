import lustre/effect.{type Effect}

import msg.{type Msg}

/// Effect to attach the blackout function to the calendar
///
@internal
pub fn attach_blackout_function(id: String) -> Effect(Msg) {
  effect.after_paint(fn(dispatch, _root) {
    attach_blackout_func(id)
    dispatch(msg.CalendarBlackoutAttached)
  })
}

/// Interface to the JavaScript function that attaches the blackout function to the calendar
///
@external(javascript, "./calendar.ffi.mjs", "attach_blackout_func")
fn attach_blackout_func(_: String) -> Nil {
  Nil
}

/// get_date is called from update() to fetch the date from the calendar
///
pub fn get_date(id: String) -> Effect(Msg) {
  effect.from(fn(dispatch) {
    let d = date(id)
    dispatch(msg.CalendarDateFetched(d))
  })
}

/// Interface to the JavaScript custom date function
///
@external(javascript, "./calendar.ffi.mjs", "date")
fn date(_: String) -> String {
  "no-date-returned"
}

/// Interface to the JavaScript custom blackout function
///
@external(javascript, "./calendar.ffi.mjs", "is_blackout_date")
@internal
pub fn is_blackout_date(_: String) -> Bool {
  False
}
