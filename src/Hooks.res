module Form = {
  type onSubmit = ReactEvent.Form.t => unit

  type formState = {
    errors: Js.Dict.t<Error.t>,
    isDirty: bool,
    isSubmitted: bool,
    isSubmitSuccessful: bool,
    isSubmitting: bool,
    submitCount: int,
    isValid: bool,
    isValidating: bool,
  }

  @ocaml.doc("Option builder for the [useForm](https://react-hook-form.com/api/useform) hook.")
  @deriving({abstract: light})
  type option = {
    @optional
    mode: [#onSubmit | #onBlur | #onChange | #onTouched | #all],
    @optional
    reValidateMode: [#onSubmit | #onBlur | #onChange],
    @optional
    defaultValues: Js.Dict.t<Value.t>,
    @optional
    criteriaMode: [#firstError | #all],
    @optional
    shouldFocusError: bool,
  }

  type t = {
    control: Control.t,
    handleSubmit: (. (@uncurry Js.Json.t, ReactEvent.Form.t) => unit) => onSubmit,
    formState: formState,
    setFocus: (. string) => unit,
    setValue: (. string, string) => unit,
    clearErrors: (. string) => unit,
    setError: (. string, Error.t) => unit,
    reset: (~defaultValues: Js.Dict.t<Value.t>=?, unit) => unit,
  }

  @ocaml.doc("Bindings for the [useForm](https://react-hook-form.com/api/useform) hook.")
  @module("react-hook-form")
  external use: (~option: option=?, unit) => t = "useForm"
}

module ArrayField = {
  type t<'data> = {
    fields: array<'data>,
    append: (. 'data) => unit,
    prepend: (. 'data) => unit,
    insert: (. int, 'data) => unit,
    remove: (. int) => unit,
    swap: (. int, int) => unit,
    move: (. int, int) => unit,
  }

  @ocaml.doc(
    "Option builder for the [useFieldArray](https://react-hook-form.com/api/usefieldarray) hook."
  )
  @deriving({abstract: light})
  type option = {
    name: string,
    control: Control.t,
    @optional
    keyName: string,
  }

  @ocaml.doc(
    "Bindings for the [useFieldArray](https://react-hook-form.com/api/usefieldarray) hook."
  )
  @module("react-hook-form")
  external use: (~option: option) => t<'data> = "useFieldArray"
}

module WatchValues = {
  type t

  @ocaml.doc("Option builder for the [useWatch](https://react-hook-form.com/api/useWatch) hook.")
  @deriving({abstract: light})
  type option = {
    name: string,
    control: Control.t,
    @optional
    defaultValue: Value.t,
  }

  @ocaml.doc("Bindings for the [useWatch](https://react-hook-form.com/api/useWatch) hook.")
  @module("react-hook-form")
  external use: (~option: option) => t = "useWatch"
}
