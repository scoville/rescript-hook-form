@@ocaml.doc("This module is used to build sync function or async function for validate in Rules.")

type rec t

@ocaml.doc("Synchronous validation")
let sync: (Js.Json.t => ValidationResult.t) => t

let syncWithCustomError: (Js.Json.t => ValidationResult.t) => t

@ocaml.doc("Asynchronous validation")
let async: (Js.Json.t => Js.Promise.t<ValidationResult.t>) => t

let asyncWithCustomError: (Js.Json.t => Js.Promise.t<ValidationResult.t>) => t
