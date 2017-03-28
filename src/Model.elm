module Model exposing ( .. )

-------------------------
-- External dependencies
-------------------------
import Http

type alias AppState =
    { queryString : String
    , queryResult : Maybe ( List String )
    }

type Msg =
    NoOp
    | UpdateQueryString String
    | SubmitQuery
    | QuerySucceed ( List String )
    | QueryFail Http.Error
