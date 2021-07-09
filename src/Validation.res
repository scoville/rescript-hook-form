@ocaml.doc("
This module is used to build sync function or async function for validate in Rules
")
@unboxed
type rec t = Any('a): t

let sync = (sync: string => bool) => Any(sync)

let async = (async: string => Js.Promise.t<bool>) => Any(async)
