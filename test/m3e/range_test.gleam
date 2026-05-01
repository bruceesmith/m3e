import gleam/list
import gleeunit/should

import m3e/range

pub fn range_test() {
  let cases = [
    // Happy paths
    #(#(5, 1, 10), Ok(5)),
    #(#(1, 1, 10), Ok(1)),
    // Boundary: min
    #(#(10, 1, 10), Ok(10)),

    // Boundary: max
    // Error cases
    #(#(0, 1, 10), Error("0 is out of range >=1 and <=10")),
    // Below min
    #(#(11, 1, 10), Error("11 is out of range >=1 and <=10")),
    // Above max
    #(#(5, 10, 1), Error("5 is out of range >=10 and <=1")),
    // Malformed bounds
  ]

  list.each(cases, fn(c) {
    let #(input, expected) = c
    let #(i, min, max) = input

    range.range(i, min, max)
    |> should.equal(expected)
  })
}
