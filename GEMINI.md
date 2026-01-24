# m3e Project Context

## Project Overview
**m3e** is a Gleam library that provides Lustre wrappers for [Material 3 Expressive components](https://matraic.github.io/m3e/). It enables developers to use these UI components within Gleam/Lustre applications in a type-safe and functional manner.

The project consists of:
-   **Core Library (`src/m3e/`)**: The Gleam source code defining the component wrappers.
-   **Tests (`test/m3e/`)**: Unit tests ensuring correct state updates and element generation.
-   **Example Application (`examples/`)**: A separate `showcase` project demonstrating the library's usage.

## Key Technologies
-   **Gleam**: The primary programming language.
-   **Lustre**: The web framework used for the components and the example app.
-   **Gleeunit**: The testing framework.
-   **Material 3 Expressive (M3E)**: The underlying web component library being wrapped.

## Build and Run

### Core Library
*   **Build**: `gleam build`
*   **Test**: `gleam test`
    *   Tests are located in `test/m3e/`.
    *   They verify component properties and the resulting Lustre element structure.

### Example Application (`examples/`)
The `examples` directory is a standalone Gleam project.
*   **Navigate to directory**: `cd examples`
*   **Build**: `make build` (or `gleam run -m lustre/dev build --no-html app`)
*   **Build Production**: `make build-prod`
*   **Run**: Use a static file server to serve the `examples/dist` directory (implied, as it builds to JS).
*   **Dependencies**: Requires `npm i @m3e/all` inside `examples/dist` (per README).

## Development Conventions

### Component Architecture
Each component (e.g., `Button`, `Card`) typically follows this pattern:
1.  **Type Definition**: A public custom type holding the component's state (e.g., `pub type Button(msg) { ... }`).
2.  **Constructors**:
    -   `button(...)`: Full constructor with all options.
    -   `basic(...)`: Convenience constructor with reasonable defaults.
3.  **Functional Updates**: Helper functions designed for the pipe operator (`|>`) to modify specific fields (e.g., `shape`, `size`, `variant`).
    -   *Example*: `button.basic("Label", button.Text) |> button.shape(button.Square)`
4.  **Rendering**: An `element` function that converts the component type into a Lustre `Element`, typically wrapping a custom element (e.g., `m3e-button`).

### Testing Strategy
-   **State Verification**: Tests check if helper functions correctly update the internal record fields.
-   **Element Verification**: Tests compare the output of `element()` against an expected Lustre `element.element` structure to ensure attributes and children are rendered correctly.
-   **File Structure**: Test files mirror the source files (e.g., `src/m3e/button.gleam` -> `test/m3e/button_test.gleam`).

### Styling
-   The library wraps web components, so much of the styling is encapsulated in the M3E custom elements.
-   Gleam code handles attributes and structural composition.
