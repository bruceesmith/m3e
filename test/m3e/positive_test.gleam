import gleam/list
import gleeunit/should

import m3e/positive

pub fn positive_test() {
  let cases = [
    // Happy paths
    #(5, Ok(5)),

    // Error cases
    #(0, Error("0 is not a positive integer")),
    // Below min
    #(-1, Error("-1 is not a positive integer")),
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c

    positive.positive(input)
    |> should.equal(expected)
  })
}
