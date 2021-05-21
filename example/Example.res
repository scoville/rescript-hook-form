module Form = {
  @react.component
  let make = () => {
    let {
      control,
      formState: {errors},
      handleSubmit,
      reset,
      setFocus,
      setValue,
      getValues,
    } = Hooks.Form.use(
      ~option=Hooks.Form.option(
        ~mode=#onSubmit,
        ~defaultValues=Js.Dict.fromArray([
          (Values.firstName, Value.make("")),
          (Values.lastName, Value.make("")),
          (Values.acceptTerms, Value.make(false)),
          (Values.hobbies, Value.make([{"id": Uuid.v4(), "name": ""}])),
        ]),
        (),
      ),
      (),
    )

    let (isShow, setIsShow) = React.useState(() => false)

    let {fields, append} = Hooks.ArrayField.use(
      ~option=Hooks.ArrayField.option(~control, ~name="hobbies", ()),
    )

    let onSubmit = (data, _event) =>
      switch data->ReCode.Decode.decodeJson(Values.decoder) {
      | Ok(value) => Js.log2("ok", value)
      | Error(error) => Js.log2("ko", error)
      }

    <form onSubmit={handleSubmit(. onSubmit)}>
      <Controller
        name=Values.firstName
        control
        rules={Rules.make(~required=true, ~minLength=2, ())}
        render={({field: {name, onBlur, onChange, ref, value}}) =>
          <div>
            <label> {name->React.string} </label>
            <input name onBlur onChange ref value />
            <ErrorMessage errors name message={"Required"->React.string} />
          </div>}
      />
      <Controller
        name=Values.lastName
        control
        rules={Rules.make(~required=true, ())}
        render={({field: {name, onBlur, onChange, ref, value}}) =>
          <div>
            <label> {name->React.string} </label>
            <input name onBlur onChange ref value />
            <ErrorMessage errors name message={"Required"->React.string} />
          </div>}
      />
      <Controller
        name=Values.acceptTerms
        control
        render={({field: {name, onBlur, onChange, ref, value}}) => {
          <div>
            <label> {name->React.string} </label>
            <input name onBlur onChange ref value type_="checkbox" />
          </div>
        }}
      />
      {fields
      ->Js.Array2.mapi((field, index) =>
        <div key={field["id"]}>
          {isShow
            ? <Controller
                name={Values.hobby(index)}
                control
                defaultValue={Value.make(field["name"])}
                rules={Rules.make(~required=true, ())}
                render={({field: {name, onBlur, onChange, ref, value}}) =>
                  <div>
                    <label> {name->React.string} </label>
                    <input name onBlur onChange ref value />
                    <ErrorMessage errors name message={"Required"->React.string} />
                  </div>}
              />
            : React.null}
        </div>
      )
      ->React.array}
      <button type_="button" onClick={_event => append(. {"id": Uuid.v4(), "name": ""})}>
        {"Add hobby"->React.string}
      </button>
      <button type_="button" onClick={_event => setValue(. "firstName", "foo")}>
        {"Set value"->React.string}
      </button>
      <button type_="button" onClick={_event => reset()}> {"Reset"->React.string} </button>
      <button type_="button" onClick={_event => setFocus(. "firstName")}>
        {"Set focus"->React.string}
      </button>
      <input type_="submit" />
      <div>
        <button type_="button" onClick={_event => setIsShow(_ => true)}>
          {"show Hobbies"->React.string}
        </button>
        <button type_="button" onClick={_event => setIsShow(_ => false)}>
          {"hide Hobbies without saving current changes"->React.string}
        </button>
        <button
          type_="button"
          onClick={_event => {
            setIsShow(_ => false)
            setValue(. "hobbies", getValues(~fieldName="hobbies"))
          }}>
          {"hide Hobbies and saved the last data"->React.string}
        </button>
      </div>
    </form>
  }
}

switch ReactDOM.querySelector("#root") {
| None => Js.Exn.raiseError("#root node not found")
| Some(root) => ReactDOM.render(<Form />, root)
}
