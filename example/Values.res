module Hobby = {
  type t = {name: string}

  let id = "id"

  let name = "name"

  let make = name => {name: name}

  let decoder = {
    open ReCode.Decode
    open ReCode.DecodeExtra

    pure(make)->Object.required(name, string->String.required)
  }

  let encoder = hobby => {
    open ReCode.Encode

    object([(id, string(hobby["id"])), (name, string(hobby["name"]))])
  }
}

type t = {
  email: string,
  firstName: string,
  lastName: string,
  acceptTerms: bool,
  hobbies: array<Hobby.t>,
}

let email = "email"
let firstName = "firstName"
let lastName = "lastName"
let acceptTerms = "acceptTerms"
let hobbies = "hobbies"
let hobby = index => `${hobbies}.${index->Belt.Int.toString}.${Hobby.name}`

let make = (email, firstName, lastName, acceptTerms, hobbies) => {
  email: email,
  firstName: firstName,
  lastName: lastName,
  acceptTerms: acceptTerms,
  hobbies: hobbies,
}

let decoder = {
  open ReCode.Decode
  open ReCode.DecodeExtra

  pure(make)
  ->Object.required(email, string)
  ->Object.required(firstName, string)
  ->Object.required(lastName, string)
  ->Object.required(acceptTerms, bool)
  ->Object.required(hobbies, array(Hobby.decoder))
}

let encoder = values => {
  open ReCode.Encode

  object([
    (email, string(values["email"])),
    (firstName, string(values["firstName"])),
    (lastName, string(values["lastName"])),
    (acceptTerms, bool(values["acceptTerms"])),
    (hobbies, array(Hobby.encoder, values["hobbies"])),
  ])
}
