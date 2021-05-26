@@ocaml.doc("This module contain unsafe Json converters.
They can be used instead of a proper Json decoder when you need
to improve the performances of a form, or want to quickly build a form.")

@ocaml.doc("Very unsafe function that can be used instead of a proper decoder (json => any)
to improve performances or quickly get the value out of a form.

Use it with care.")
external jsonToAny: Js.Json.t => 'a = "%external"

@ocaml.doc("Very unsafe function that can be used instead of a proper encoder (any => json)
to improve performances or quickly get the value out of a form.

Use it with care.")
external anyToJson: 'a => Js.Json.t = "%external"
