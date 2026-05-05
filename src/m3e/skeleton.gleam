//// Skeleton is a visual placeholder that mimics the layout of content while it's still loading.
////
//// This file was generated:
////    By: m3e/generator version 0.1.0
////    At: 2026-05-05T14:38:23+10:00
////
////          DO NOT EDIT
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import m3e/attr
import m3e/skeleton_animation.{type SkeletonAnimation}
import m3e/skeleton_shape.{type SkeletonShape}

// --- Types ---

/// Skeleton is a View Model for this component
///
/// ## Fields:
///
/// - animation: The animation effect of the skeleton.
/// - shape: The shape of the skeleton.
/// - loaded: Whether the content of the skeleton has been loaded.
///
pub opaque type Skeleton {
  Skeleton(animation: SkeletonAnimation, shape: SkeletonShape, loaded: Loaded)
}

/// Loaded is whether the content of the skeleton has been loaded.
///
pub type Loaded {
  IsLoaded
  IsNotLoaded
}

// --- Defaults ---

pub const default_animation: SkeletonAnimation = skeleton_animation.Wave

pub const default_shape: SkeletonShape = skeleton_shape.Auto

pub const default_loaded: Loaded = IsNotLoaded

// --- Configuration ---

/// Config is a public record for configuring this component.
///
pub type Config {
  Config(animation: SkeletonAnimation, shape: SkeletonShape, loaded: Loaded)
}

/// default_config is the default configuration for this component.
///
pub fn default_config() -> Config {
  Config(
    animation: skeleton_animation.Wave,
    shape: skeleton_shape.Auto,
    loaded: IsNotLoaded,
  )
}

// --- Constructors ---

/// from_config creates a new Skeleton from the given configuration.
///
pub fn from_config(config: Config) -> Skeleton {
  Skeleton(
    animation: config.animation,
    shape: config.shape,
    loaded: config.loaded,
  )
}

/// new creates a new Skeleton with the default configuration.
///
pub fn new() -> Skeleton {
  from_config(default_config())
}

// --- Setters ---

/// animation sets the value of animation for this Skeleton.
///
pub fn animation(record: Skeleton, animation: SkeletonAnimation) -> Skeleton {
  Skeleton(..record, animation: animation)
}

/// shape sets the value of shape for this Skeleton.
///
pub fn shape(record: Skeleton, shape: SkeletonShape) -> Skeleton {
  Skeleton(..record, shape: shape)
}

/// loaded sets the value of loaded for this Skeleton.
///
pub fn loaded(record: Skeleton, loaded: Loaded) -> Skeleton {
  Skeleton(..record, loaded: loaded)
}

// --- Renderers ---

/// render creates a Lustre Element for a Skeleton
///
pub fn render(
  model: Skeleton,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element(
    "m3e-skeleton",
    list.flatten([
      [
        attr.with_default(
          "animation",
          skeleton_animation.to_string(model.animation),
          skeleton_animation.to_string(default_animation),
        ),
        attr.with_default(
          "shape",
          skeleton_shape.to_string(model.shape),
          skeleton_shape.to_string(default_shape),
        ),
        attr.boolean("loaded", model.loaded == IsLoaded),
      ],
      attributes,
    ])
      |> list.filter(fn(a) { a != attribute.none() }),
    children,
  )
}

/// render_config creates a Lustre Element from a Skeleton Config
///
pub fn render_config(
  c: Config,
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  render(from_config(c), attributes, children)
}
