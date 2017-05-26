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
    , candidates  : Maybe ( List String )
    }

type Msg =
    NoOp
    | UpdateQueryString String
    | SubmitQuery
    | SubmitCandidateQuery
    | QueryCandidateSucceeded ( List String )
    | QuerySucceed ( List String )
    | QueryFail Http.Error
