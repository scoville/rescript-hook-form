@ocaml.doc(
  "Bindings for the [ErrorMessage](https://react-hook-form.com/api/useformstate/errormessage#main) component."
)
@module("@hookform/error-message")
@react.component
external make: (
  ~errors: Js.Dict.t<Error.t>,
  ~name: string,
  ~message: React.element=?,
) => React.element = "ErrorMessage"
