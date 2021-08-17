@@ocaml.doc("This module is used to build sync function or async function for validate in Rules.")

type rec t

@ocaml.doc("Synchronous validation")
let sync: (string => bool) => t

@ocaml.doc("Asynchronous validation")
let async: (string => Js.Promise.t<bool>) => t
