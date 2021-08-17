module OnChangeArg: {
  @@ocaml.doc(
    "This module is used to build event or value argument to pass down to the `onChange` callback."
  )

  type rec t

  type kind = Event(ReactEvent.Form.t) | Value(Js.Json.t)

  @ocaml.doc("Takes a `ReactEvent.Form.t` and return an `onChange` argument.
Useful for dealing with native form inputs.")
  let event: ReactEvent.Form.t => t

  @ocaml.doc("Takes a `Js.Json.t` and return an `onChange` argument.
This function allows you to set the input value to any arbitrary value.")
  let value: Js.Json.t => t

  let classify: t => kind
} = {
  @unboxed
  type rec t = Any('a): t

  type kind = Event(ReactEvent.Form.t) | Value(Js.Json.t)

  let event = eventHandler => Any(eventHandler)

  let value = valueHandler => Any(valueHandler)

  let classify = (Any(unknown)) =>
    unknown->Js.typeof == "object" &&
    unknown->Js.Nullable.return->Js.Nullable.isNullable->not &&
    Obj.magic(unknown)["_reactName"] == "onChange"
      ? Event(Obj.magic(unknown))
      : Value(Obj.magic(unknown))
}

@ocaml.doc(
  "The `field` object described [here](https://react-hook-form.com/api/usecontroller/controller#main)."
)
type field = {
  name: string,
  onBlur: unit => unit,
  onChange: OnChangeArg.t => unit,
  ref: ReactDOM.domRef,
  value: Js.Json.t,
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
