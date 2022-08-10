module Hobby = {
  type t = {name: string}

  let name = "name"

  let make = name => {name: name}

  let decoder = {
    open ReCode.Decode
    open ReCode.DecodeExtra

    pure(make)->Object.required(name, string->String.required)
  }

  let encoder = hobby => {
    open ReCode.Encode

    object([(name, string(hobby["name"]))])
  }
}

type t = {
  email: string,
  firstName: string,
  lastName: string,
  location: string,
  acceptTerms: bool,
  hobbies: array<Hobby.t>,
}

let email = "email"
let firstName = "firstName"
let lastName = "lastName"
let location = "location"
let acceptTerms = "acceptTerms"
let hobbies = "hobbies"
let hobby = index => `${hobbies}.${index->Belt.Int.toString}.${Hobby.name}`

let make = (email, firstName, lastName, acceptTerms, hobbies, location) => {
  email: email,
  firstName: firstName,
  lastName: lastName,
  location: location,
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
  ->Object.required(location, string)
}

let encoder = values => {
  open ReCode.Encode

  object([
    (email, string(values["email"])),
    (firstName, string(values["firstName"])),
    (lastName, string(values["lastName"])),
    (location, string(values["location"])),
    (acceptTerms, bool(values["acceptTerms"])),
    (hobbies, array(Hobby.encoder, values["hobbies"])),
  ])
}
