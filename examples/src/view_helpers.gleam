import layout
import lustre/element.{type Element}
import lustre/element/html
import m3e/card
import model
import msg.{type Msg}

/// page builds a page showcasing one of the M3E wrapper components
///
pub fn page(displays: List(Element(Msg))) -> Element(Msg) {
  html.div(
    [
      layout.frame_style(),
    ],
    displays,
  )
}

/// panel builds a panel showcasing one aspect of tje showcased warpper
///
pub fn panel(
  model: model.Model,
  description: String,
  content: fn(model.Model) -> Element(Msg),
) -> Element(Msg) {
  card.render_config(
    card.Config(..card.default_config(), variant: card.Outlined),
    [
      layout.card_style(),
    ],
    [
      html.div(
        [
          layout.card_content_style(),
          card.slot(card.Content),
        ],
        [
          element.text(description),
          content(model),
        ],
      ),
    ],
  )
}
