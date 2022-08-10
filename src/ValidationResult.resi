@ocaml.doc(
  "The union type for the result of a validator function;  allows validation functions to return either boolean or a string"
)
type rec t

let boolResult: bool => t

let stringResult: string => t
