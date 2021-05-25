module Form = {
  @react.component
  let make = () => {
    let {
      control,
      formState: {errors},
      getValues,
      handleSubmit,
      reset,
      setFocus,
      setValue,
    } = Hooks.Form.use(.
      ~config=Hooks.Form.config(
        ~mode=#onSubmit,
        ~defaultValues=Values.encoder({
          "firstName": "",
          "lastName": "",
          "acceptTerms": false,
          "hobbies": [{"id": Uuid.v4(), "name": ""}],
        }),
        (),
      ),
      (),
    )

    let (hobbiesAreShown, setHobbiesAreShown) = React.useState(() => false)

    let {fields, append} = Hooks.ArrayField.use(.
      ~config=Hooks.ArrayField.config(~control, ~name="hobbies", ()),
      (),
    )

    let hobbies = Hooks.WatchValues.use(.
      ~config=Hooks.WatchValues.config(~control, ~name="hobbies", ()),
      (),
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
      {hobbiesAreShown
        ? fields
          ->Js.Array2.mapi((field, index) =>
            <div key={field["id"]}>
              <Controller
                name={Values.hobby(index)}
                control
                defaultValue={ReCode.Encode.string(field["name"])}
                rules={Rules.make(~required=true, ())}
                render={({field: {name, onBlur, onChange, ref, value}}) =>
                  <div>
                    <label> {name->React.string} </label>
                    <input name onBlur onChange ref value />
                    <ErrorMessage errors name message={"Required"->React.string} />
                  </div>}
              />
            </div>
          )
          ->React.array
        : React.null}
      {hobbiesAreShown
        ? <div>
            {"Hobbies: "->React.string}
            {switch hobbies->ReCode.Decode.decodeJson(ReCode.Decode.array(Values.Hobby.decoder)) {
            | Ok(hobbies) =>
              hobbies->Js.Array2.map(({name}) => name)->Js.Array2.joinWith(", ")->React.string
            | Error(_) => React.null
            }}
          </div>
        : React.null}
      <button type_="button" onClick={_event => append(. {"id": Uuid.v4(), "name": ""})}>
        {"Add hobby"->React.string}
      </button>
      <button
        type_="button" onClick={_event => setValue(. "firstName", ReCode.Encode.string("foo"))}>
        {"Set value"->React.string}
      </button>
      <button type_="button" onClick={_event => reset(. None)}> {"Reset"->React.string} </button>
      <button type_="button" onClick={_event => setFocus(. "firstName")}>
        {"Set focus"->React.string}
      </button>
      <button
        type_="button"
        onClick={_event => {
          if hobbiesAreShown {
            switch getValues(. None)->ReCode.Decode.decodeJson(
              ReCode.Decode.field("hobbies", ReCode.Decode.raw),
            ) {
            | Ok(hobbies) => setValue(. "hobbies", hobbies)
            | Error(_) => ignore()
            }
          }

          setHobbiesAreShown(not)
        }}>
        {`${hobbiesAreShown ? "Hide" : "Show"} hobbies`->React.string}
      </button>
      <input type_="submit" />
    </form>
  }
}

switch ReactDOM.querySelector("#root") {
| None => Js.Exn.raiseError("#root node not found")
| Some(root) => ReactDOM.render(<Form />, root)
}
