module Model exposing ( .. )

type alias AppState =
    { queryString : String
    , queryStatus : Int
    }

type Msg =
    NoOp
    | UpdateQueryString String
    | SubmitQuery
