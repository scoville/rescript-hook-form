type rec t

let sync: (string => bool) => t

let async: (string => Js.Promise.t<bool>) => t
