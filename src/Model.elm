module Model exposing ( .. )

-------------------------
-- External dependencies
-------------------------
import Http

type alias AppState =
    { queryString : String
    , queryStatus : Int
    }

type Msg =
    NoOp
    | UpdateQueryString String
    | SubmitQuery
    | QuerySucceed ( List String )
    | QueryFail Http.Error
