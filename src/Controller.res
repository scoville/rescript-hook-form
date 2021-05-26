@ocaml.doc(
  "The `field` object described [here](https://react-hook-form.com/api/usecontroller/controller#main)."
)
type field = {
  name: string,
  onBlur: ReactEvent.Focus.t => unit,
  onChange: ReactEvent.Form.t => unit,
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
