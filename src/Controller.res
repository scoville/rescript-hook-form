module OnChangeArg: {
  @@ocaml.doc(
    "This module is used to build event or value argument to pass down to the `onChange` callback."
  )

  type rec t

  @ocaml.doc("Takes a `ReactEvent.Form.t` and return an `onChange` argument.
Useful for dealing with native form inputs.")
  let event: ReactEvent.Form.t => t

  @ocaml.doc("Takes a `Js.Json.t` and return an `onChange` argument.
This function allows you to set the input value to any arbitrary value.")
  let value: Js.Json.t => t
} = {
  @unboxed
  type rec t = Any('a): t

  let event = eventHandler => Any(eventHandler)

  let value = valueHandler => Any(valueHandler)
}

@ocaml.doc("Simple helper that simplifies `onChange` argument handling when it's passed down to native inputs.

_Has a small runtime cost._

Example:

```
<Controller
  render={({field: {onChange}}) =>
    <input onChange={event => onChange(Controller.OnChangeArg.event(event))} />
  }
/>
```

Can be written:

```
<Controller
  render={({field: {onChange}}) =>
    <input onChange={Controller.handleEvent(onChange)} />
  }
/>
```
")
let handleEvent = (onChange, event) => onChange(OnChangeArg.event(event))

@ocaml.doc(
  "The `field` object described [here](https://react-hook-form.com/api/usecontroller/controller#main)."
)
type field = {
  name: string,
  onBlur: unit => unit,
  onChange: OnChangeArg.t => unit,
  ref: ReactDOM.domRef,
  // This is not correct, the value can be a bool or an int
  // The value should be considered opaque and never access directly
  value: string,
}

@ocaml.doc(
  "The `fieldState` object described [here](https://react-hook-form.com/api/usecontroller/controller#main)."
)
type fieldState = {invalid: bool, isTouched: bool, isDirty: bool, error: Error.t}

@ocaml.doc("The values injected into the rendered component.")
type render = {field: field, fieldState: fieldState}

@ocaml.doc("The [Controller](https://react-hook-form.com/api/usecontroller/controller#main) component
eases the integration with existing UI libraries and controlled inputs flows.")
@module("react-hook-form")
@react.component
external make: (
  ~name: string,
  ~control: Control.t,
  ~render: render => React.element,
  ~defaultValue: Js.Json.t=?,
  ~rules: Rules.t=?,
) => React.element = "Controller"
