open ReCode.Decode
open ReCode.DecodeExtra

module Hobby = {
  type t = {name: string}

  let name = "name"

  let make = name => {name: name}

  let decoder = pure(make)->Object.required(name, string)
}

type t = {firstName: string, lastName: string, acceptTerms: bool, hobbies: array<Hobby.t>}

let firstName = "firstName"
let lastName = "lastName"
let acceptTerms = "acceptTerms"
let hobbies = "hobbies"
let hobby = index => `${hobbies}.${index->Belt.Int.toString}.${Hobby.name}`

let make = (firstName, lastName, acceptTerms, hobbies) => {
  firstName: firstName,
  lastName: lastName,
  acceptTerms: acceptTerms,
  hobbies: hobbies,
}

let decoder =
  pure(make)
  ->Object.required(firstName, string)
  ->Object.required(lastName, string)
  ->Object.required(acceptTerms, bool)
  ->Object.required(hobbies, array(Hobby.decoder))
