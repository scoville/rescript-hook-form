@unboxed
type rec t = Value('any): t

@ocaml.doc("Makes an arbitrary value to be passed down to the `defaultValue` prop
or the `defaultValues` option for `Hooks.Form.use`.")
let make = any => Value(any)
