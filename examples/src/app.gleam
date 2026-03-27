import init
import lustre
import update
import view

pub fn main() {
  let app = lustre.application(init.init, update.update, view.view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}
