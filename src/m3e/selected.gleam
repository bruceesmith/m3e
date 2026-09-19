import gleam/list

/// Selected is a custom type to handle TypeScript fields with type "string | readonly string[] | null"
///
pub type Selected {
  One(value: String)
  Many(values: List(String))
  None
}

pub const default_selected = None

pub fn to_string(s: Selected) -> String {
  case s {
    One(v) -> v
    Many(v) -> {
      let r = list.reduce(v, fn(acc, x) { acc <> x })
      case r {
        Ok(vv) -> vv
        Error(Nil) -> ""
      }
    }
    None -> ""
  }
}
