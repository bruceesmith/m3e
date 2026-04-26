# Roadmap

This document outlines the planned improvements and future directions for the **m3e** project.

## Possible future direction

The original 1.* version and the in-development 2.0 version cover the M3E custom HTML components, their attributes, and
their Shadow DOM slots. No attempt has been made to provide Gleam interfaces for the custom CSS variables associated
with the M3E components. So a future investigation will determine if it makes sense to cater to these variables, and if
so, how.

## Current roadmap (towards 2.0),

All three of the previous road map goals will be addressed in a single significant change: programmed Gleam code generation from the M3E Custom Element Manifest, and matching generation of unit tests. This will 
- totally replace hand written Gleam code and unit tests, 
- ensure 
  - consistent and predictable Gleam API
  - consistent unit test coverage
  - coverage of the full set of released Material 3 Expressive components
- provide fast turnaround when a new component is added to Material 3 Expressive

## Previous roadmap (the 1.* generation)

1.  **Track M3E Developments**: Continue to monitor and incorporate updates from the source-of-truth [Material 3 Expressive (M3E)](https://matraic.github.io/m3e/) project to ensure compatibility and feature parity.
2.  **Improve Unit Tests**: Enhance the test suite to provide better coverage and more robust verification of component behavior and rendered output.
3.  **Optimize Attribute Generation**: Expand the use of `helpers.attribute_with_default()` across all components. This ensures that HTML attributes are only generated when their value differs from the default, resulting in cleaner rendered HTML.
