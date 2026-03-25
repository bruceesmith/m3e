import gleeunit
import gleeunit/should
import m3e/config

pub fn main() {
  gleeunit.main()
}

pub fn clamp_to_restricted_size_test() {
  // When input is already a restricted size, it should be returned
  config.clamp_to_restricted_size(config.Small, config.Large)
  |> should.equal(config.Small)
  config.clamp_to_restricted_size(config.Medium, config.Large)
  |> should.equal(config.Medium)
  config.clamp_to_restricted_size(config.Large, config.Small)
  |> should.equal(config.Large)

  // When input is unrestricted, it should fallback to default if default is restricted
  config.clamp_to_restricted_size(config.ExtraSmall, config.Medium)
  |> should.equal(config.Medium)
  config.clamp_to_restricted_size(config.ExtraLarge, config.Large)
  |> should.equal(config.Large)

  // When both input and default are unrestricted, it should return the module default (Small)
  config.clamp_to_restricted_size(config.ExtraSmall, config.ExtraLarge)
  |> should.equal(config.default_size)
}

pub fn size_to_string_test() {
  config.size_to_string(config.ExtraSmall) |> should.equal("extra-small")
  config.size_to_string(config.Small) |> should.equal("small")
  config.size_to_string(config.Medium) |> should.equal("medium")
  config.size_to_string(config.Large) |> should.equal("large")
  config.size_to_string(config.ExtraLarge) |> should.equal("extra-large")
}
