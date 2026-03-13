import gleeunit/should
import m3e/list_variant

pub fn default_variant_test() {
  list_variant.default_variant
  |> should.equal(list_variant.Standard)
}

pub fn variant_to_string_test() {
  list_variant.variant_to_string(list_variant.Standard)
  |> should.equal("standard")

  list_variant.variant_to_string(list_variant.Segmented)
  |> should.equal("segmented")
}
