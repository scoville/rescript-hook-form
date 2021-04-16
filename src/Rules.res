module Validation = {
  type t = Sync(string => bool) | Async(string => Js.Promise.t<bool>)
}

@deriving({abstract: light})
type t = {
  @optional
  required: bool,
  @optional
  maxLength: int,
  @optional
  minLength: int,
  @optional
  max: int,
  @optional
  min: int,
  @optional
  pattern: Js.Re.t,
  @optional
  validate: Js.Dict.t<Validation.t>,
}

@ocaml.doc("Creates a set of `rules`, or validations.")
let make = t
