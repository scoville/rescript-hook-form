@ocaml.doc(
  "Custom validator fuction to check that the input has at least three characters. Will return a boolean."
)
let minThreeCharsValue = value => {
  let decodedValue = value->Js.Json.decodeString->Belt.Option.getWithDefault("")

  ValidationResult.boolResult(decodedValue->Js.String2.length >= 3)
}

let minThreeChars = Validation.sync(minThreeCharsValue)

@ocaml.doc(
  "Custom validator fuction to check that the input has at most ten characters. Will throw a custom error otherwise."
)
let maxTenCharsValue = value => {
  let decodedValue = value->Js.Json.decodeString->Belt.Option.getWithDefault("")

  decodedValue->Js.String2.length > 10
    ? ValidationResult.stringResult("There are over ten characters in this input.")
    : ValidationResult.boolResult(true)
}

let maxTenChars = Validation.syncWithCustomError(maxTenCharsValue)
