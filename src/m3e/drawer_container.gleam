//// drawer_container provides Lustre support for the [M3E DrawerContainer component](https://matraic.github.io/m3e/#/components/drawer_container.html)

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/helpers

// --- TYPES ---

/// Divider determines if a divider is shown
/// 
pub type Divider {
  ShowDivider
  HideDivider
}

pub const default_divider: Divider = HideDivider

/// DrawerContainer is a responsive layout container that manages collapsible left and right drawers alongside main content
/// 
/// ## Fields:
/// - end: Whether the end drawer is open
/// - end_mode: The behavior mode of the end drawer
/// - end_divider: Whether to show a divider between the end drawer and content for `side` mode
/// - start: Whether the start drawer is open
/// - start_mode: The behavior mode of the start drawer
/// - start_divider: Whether to show a divider between the start drawer and content for `side` mode
///
pub opaque type DrawerContainer(msg) {
  DrawerContainer(
    end: State,
    end_divider: Divider,
    end_drawer: Option(Element(msg)),
    end_mode: Mode,
    main_content: Element(msg),
    start: State,
    start_divider: Divider,
    start_drawer: Option(Element(msg)),
    start_mode: Mode,
  )
}

/// Mode is the behaviour of a drawer
/// 
pub type Mode {
  Auto
  Over
  Push
  Side
}

/// Default Mode
/// 
pub const default_mode = Auto

/// Slot gives type-safe names to each of the defined HTML named slots
/// 
pub type Slot {
  End
  // Renders the end drawer 
  Start
  // Renders the start drawer 
}

/// State determines if a drawer is open or closed
/// 
pub type State {
  Open
  Closed
}

pub const default_state: State = Closed

// --- CONFIGURATION ---

/// Config is a transparent record used for bulk configuration
/// 
pub type Config(msg) {
  Config(
    end: State,
    end_divider: Divider,
    end_drawer: Option(Element(msg)),
    end_mode: Mode,
    main_content: Element(msg),
    start: State,
    start_divider: Divider,
    start_drawer: Option(Element(msg)),
    start_mode: Mode,
  )
}

/// default_config provides a starting point for configuration with sensible defaults.
/// 
pub fn default_config() -> Config(msg) {
  Config(
    end: default_state,
    end_divider: default_divider,
    end_drawer: None,
    end_mode: default_mode,
    main_content: element.none(),
    start: default_state,
    start_divider: default_divider,
    start_drawer: None,
    start_mode: default_mode,
  )
}

// --- CONSTRUCTORS ---

/// from_config bridges the transparent Config to the Opaque type
/// 
pub fn from_config(config: Config(msg)) -> DrawerContainer(msg) {
  DrawerContainer(
    end: case config.end_drawer {
      Some(_) -> config.end
      None -> Closed
    },
    end_divider: case config.end_drawer {
      Some(_) -> config.end_divider
      None -> HideDivider
    },
    end_drawer: config.end_drawer,
    end_mode: case config.end_drawer {
      Some(_) -> config.end_mode
      None -> default_mode
    },
    main_content: config.main_content,
    start: case config.start_drawer {
      Some(_) -> config.start
      None -> Closed
    },
    start_divider: case config.start_drawer {
      Some(_) -> config.start_divider
      None -> HideDivider
    },
    start_drawer: config.start_drawer,
    start_mode: case config.start_drawer {
      Some(_) -> config.start_mode
      None -> default_mode
    },
  )
}

/// new creates a DrawerContainer with defaults
/// 
pub fn new() -> DrawerContainer(msg) {
  from_config(default_config())
}

// --- SETTERS ---

/// end sets the `end` fieldq
/// 
pub fn end(c: DrawerContainer(msg), end: State) -> DrawerContainer(msg) {
  case c.end_drawer {
    Some(_) -> DrawerContainer(..c, end: end)
    None -> c
  }
}

/// end_divider sets the `end_divider` field
/// 
pub fn end_divider(
  c: DrawerContainer(msg),
  end_divider: Divider,
) -> DrawerContainer(msg) {
  case c.end_drawer {
    Some(_) -> DrawerContainer(..c, end_divider: end_divider)
    None -> c
  }
}

/// end_drawer sets the `end_drawer` field
/// 
pub fn end_drawer(
  c: DrawerContainer(msg),
  end_drawer: Option(Element(msg)),
) -> DrawerContainer(msg) {
  DrawerContainer(..c, end_drawer: end_drawer)
}

/// end_mode sets the `end_mode` field
/// 
pub fn end_mode(c: DrawerContainer(msg), end_mode: Mode) -> DrawerContainer(msg) {
  case c.end_drawer {
    Some(_) -> DrawerContainer(..c, end_mode: end_mode)
    None -> c
  }
}

/// main_content sets the `main_content` field
/// 
pub fn main_content(
  c: DrawerContainer(msg),
  main_content: Element(msg),
) -> DrawerContainer(msg) {
  DrawerContainer(..c, main_content: main_content)
}

/// start sets the `start` field
/// 
pub fn start(c: DrawerContainer(msg), start: State) -> DrawerContainer(msg) {
  case c.start_drawer {
    Some(_) -> DrawerContainer(..c, start: start)
    None -> c
  }
}

/// start_divider sets the `start_divider` field
/// 
pub fn start_divider(
  c: DrawerContainer(msg),
  start_divider: Divider,
) -> DrawerContainer(msg) {
  case c.start_drawer {
    Some(_) -> DrawerContainer(..c, start_divider: start_divider)
    None -> c
  }
}

/// start_drawer sets the `start_drawer` field
/// 
pub fn start_drawer(
  c: DrawerContainer(msg),
  start_drawer: Option(Element(msg)),
) -> DrawerContainer(msg) {
  DrawerContainer(..c, start_drawer: start_drawer)
}

/// start_mode sets the `start_mode` field
/// 
pub fn start_mode(
  c: DrawerContainer(msg),
  start_mode: Mode,
) -> DrawerContainer(msg) {
  case c.start_drawer {
    Some(_) -> DrawerContainer(..c, start_mode: start_mode)
    None -> c
  }
}

// --- RENDERING ---

/// render creates a Lustre Element from a DrawerContainer
///
/// ## Parameters:
/// - c: a DrawerContainer
/// - attributes: a list of additional Attributes
///
pub fn render(
  c: DrawerContainer(msg),
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  let drawers =
    [
      case c.start_drawer {
        Some(d) -> d
        None -> element.none()
      },
      c.main_content,
      case c.end_drawer {
        Some(d) -> d
        None -> element.none()
      },
    ]
    |> list.filter(fn(e) { e != element.none() })

  element.element(
    "m3e-drawer-container",
    list.flatten([
      case c.end_drawer {
        Some(_) -> {
          [
            helpers.boolean_attribute("end", c.end == Open),
            helpers.boolean_attribute(
              "end-divider",
              c.end_divider == ShowDivider,
            ),
            attribute.attribute("end-mode", mode_to_string(c.end_mode)),
          ]
        }
        None -> []
      },
      case c.start_drawer {
        Some(_) -> {
          [
            helpers.boolean_attribute("start", c.start == Open),
            helpers.boolean_attribute(
              "start-divider",
              c.start_divider == ShowDivider,
            ),
            attribute.attribute("start-mode", mode_to_string(c.start_mode)),
          ]
        }
        None -> []
      },
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    drawers,
  )
}

/// render_config creates a Lustre Element directly from a Config
/// 
/// ## Parameters:
/// - config: a Config
/// - attributes: a list of additional Attributes
///
pub fn render_config(
  config: Config(msg),
  attributes: List(Attribute(msg)),
) -> Element(msg) {
  render(from_config(config), attributes)
}

/// slot creates a Lustre 'slot' Attribute(msg) for a Slot
/// 
pub fn slot(s: Slot) -> Attribute(msg) {
  case s {
    End -> attribute.attribute("slot", "end")
    Start -> attribute.attribute("slot", "start")
  }
}

// --- PRIVATE INTERNAL HELPERS ---

/// Convert a Mode to a string
/// 
fn mode_to_string(m: Mode) -> String {
  case m {
    Auto -> "auto"
    Over -> "over"
    Push -> "push"
    Side -> "side"
  }
}
