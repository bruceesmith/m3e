////// calendar provides Lustre support for the [M3E Calendar component](https:///matraic.github.io/m3e/#/components/calendar.html)
//// View is the view used to select a date
////

import gleam/list

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}

import m3e/cal_date.{type State}

// --- Types ---

/// Calendar provides structured navigation and selection across month, year, and multi_year views
///
/// ## Fields:
/// - state: The state of the calendar, including the selected date and view.
///
pub opaque type Calendar {
  Calendar(state: State)
}

/// Slot gives type-safe names to each of the defined HTML named slots
///
pub type Slot {
  Header
  // Renders the header of the calendar
}

// --- CONFIGURATION ---

/// Config allows for a declarative configuration of the Calendar
///
pub type Config {
  Config(state: State)
}

/// Default config
///
pub fn default_config() -> Config {
  Config(state: cal_date.from_config(cal_date.default_config()))
}

// --- CONSTRUCTORS ---

/// from_config creates a Calendar from a Config
///
pub fn from_config(c: Config) -> Calendar {
  Calendar(state: c.state)
}

/// new creates a new Calendar
///
pub fn new() -> Calendar {
  from_config(default_config())
}

// --- SETTERS ---

/// state sets the `state` field
///
pub fn state(_: Calendar, state: State) -> Calendar {
  Calendar(state: state)
}

// --- RENDERING ---

/// render creates a Lustre Element(msg) from a Calendar
///
pub fn render(c: Calendar, attributes: List(Attribute(msg))) -> Element(msg) {
  element.element(
    "m3e-calendar",
    list.flatten([
      cal_date.attributes(c.state),
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    [],
  )
}

/// render_config creates a Lustre Element(msg) from a Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(c), attributes)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
///
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    Header -> attribute.attribute("slot", "header")
  }
}
// --- PRIVATE HELPER FUNCTIONS ---
