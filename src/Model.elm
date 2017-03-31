module Model exposing ( .. )

-------------------------
-- External dependencies
-------------------------
import Http

type alias AppState =
    { queryString : String
    , queryResult : Maybe ( List String )
    , isQuerying  : Bool
    , queryError  : Maybe ( Http.Error )
    }

type Msg =
    NoOp
    | UpdateQueryString String
    | SubmitQuery
    | QuerySucceed ( List String )
    | QueryFail Http.Error
