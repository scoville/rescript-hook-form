@ocaml.doc("The error object.")
type t = {message: string, @as("type") type_: string}

@ocaml.doc("Takes an error dictionnary and a name and return an error or None.

See https://react-hook-form.com/advanced-usage#ErrorMessages for more (\"Lodash get\").
")
@module("react-hook-form")
external get: (Js.Dict.t<t>, string) => option<t> = "get"
