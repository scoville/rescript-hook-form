@@ocaml.doc("This module contain unsafe Json converters.
They can be used instead of a proper Json decoder when you need
to improve the performances of a form, or want to quickly build a form.")

@ocaml.doc("Very unsafe function that can be used instead of a proper decoder (json => any)
to improve performances or quickly get the value out of a form.

Use it with care.")
external jsonToAny: Js.Json.t => 'a = "%identity"

@ocaml.doc("Very unsafe function that can be used instead of a proper encoder (any => json)
to improve performances or quickly get the value out of a form.

Use it with care.")
external anyToJson: 'a => Js.Json.t = "%identity"

@ocaml.doc("Can be useful when you want to pass the `value` argument received
from a Controller's render function to a native input.

Notice that such values can actually be of any (serializable) type so use with care.

Example:

```
<Controller
  render={({field: {value}}) =>
    <input value={Unsafe.valueToString(value)} />
  }
/>
```
")
external valueToString: Js.Json.t => string = "%identity"

@ocaml.doc("Can be useful when you want to pass the `value` argument received
from a Controller's render function to a native checkbox.

Notice that such values can actually be of any (serializable) type so use with care.")
external valueToBool: Js.Json.t => bool = "%identity"
