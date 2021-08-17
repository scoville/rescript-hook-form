@@ocaml.doc("This module is used to build sync function or async function for validate in Rules.")

type rec t

@ocaml.doc("Synchronous validation")
let sync: (Js.Json.t => bool) => t

@ocaml.doc("Asynchronous validation")
let async: (Js.Json.t => Js.Promise.t<bool>) => t
