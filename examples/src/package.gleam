import lustre/element.{type Element}

import model
import msg.{type Msg}

/// Package is used to describe each component of the application. The view module has a private packages() function
/// in which provides a list of all the available Packages for other functions in view, ensuring there is a single
/// source of truth across view. To ready a component for inclusion in view, a component should publish a package()
/// funciton that returns its Package record, and a call to that packages() function should be included in view's packages() list
///
pub type Package {
  Package(
    state: model.State,
    label: String,
    view: fn(model.Model) -> Element(Msg),
    msg: Msg,
  )
}
