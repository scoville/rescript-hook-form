module Form = {
  type onSubmit = ReactEvent.Form.t => unit

  type formState = {
    errors: Js.Dict.t<Error.t>,
    isDirty: bool,
    isSubmitted: bool,
    isSubmitting: bool,
    isSubmitSuccessful: bool,
    isValid: bool,
    isValidating: bool,
    submitCount: int,
  }

  @ocaml.doc("Config builder for the [useForm](https://react-hook-form.com/api/useform) hook.")
  @deriving({abstract: light})
  type config = {
    @optional
    criteriaMode: [#firstError | #all],
    @optional
    defaultValues: Js.Json.t,
    @optional
    mode: [#onSubmit | #onBlur | #onChange | #onTouched | #all],
    @optional
    reValidateMode: [#onSubmit | #onBlur | #onChange],
    @optional
    shouldFocusError: bool,
  }

  type t = {
    clearErrors: (. string) => unit,
    control: Control.t,
    formState: formState,
    getValues: (. option<string>) => Js.Json.t,
    handleSubmit: (. (@uncurry Js.Json.t, ReactEvent.Form.t) => unit) => onSubmit,
    reset: (. option<Js.Json.t>) => unit,
    setError: (. string, Error.t) => unit,
    setFocus: (. string) => unit,
    setValue: (. string, Js.Json.t) => unit,
  }

  @ocaml.doc("Bindings for the [useForm](https://react-hook-form.com/api/useform) hook.")
  @module("react-hook-form")
  external use: (. ~config: config=?, unit) => t = "useForm"
}

module ArrayField = {
  type t<'value> = {
    append: (. 'value) => unit,
    fields: array<'value>,
    insert: (. int, 'value) => unit,
    move: (. int, int) => unit,
    prepend: (. 'value) => unit,
    remove: (. int) => unit,
    swap: (. int, int) => unit,
    update: (. int, 'value) => unit,
  }

  @ocaml.doc(
    "Config builder for the [useFieldArray](https://react-hook-form.com/api/usefieldarray) hook."
  )
  @deriving({abstract: light})
  type config = {
    control: Control.t,
    @optional
    keyName: string,
    name: string,
  }

  @ocaml.doc(
    "Bindings for the [useFieldArray](https://react-hook-form.com/api/usefieldarray) hook."
  )
  @module("react-hook-form")
  external use: (. ~config: config=?, unit) => t<'value> = "useFieldArray"
}

module WatchValues = {
  @ocaml.doc("Config builder for the [useWatch](https://react-hook-form.com/api/usewatch) hook.")
  @deriving({abstract: light})
  type config = {
    @optional
    defaultValue: Js.Json.t,
    control: Control.t,
    name: string,
  }

  @ocaml.doc("Bindings for the [useWatch](https://react-hook-form.com/api/usewatch) hook.")
  @module("react-hook-form")
  external use: (. ~config: config=?, unit) => Js.Json.t = "useWatch"
}
