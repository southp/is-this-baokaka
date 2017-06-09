module Model exposing ( .. )

-------------------------
-- External dependencies
-------------------------
import Http
import Array exposing ( .. )

type alias AppState =
    { queryString : String
    , queryResult : Maybe ( List String )
    , isQuerying  : Bool
    , queryError  : Maybe ( Http.Error )
    , candidates  : Maybe ( Array String )
    , candidateIndex : Int
    }

type Msg =
    NoOp
    | UpdateQueryString String
    | UpdateAndSubmit String
    | DecreaseCandidateIndex
    | IncreaseCandidateIndex
    | SubmitQuery
    | SubmitCandidateQuery
    | QueryCandidateSucceeded ( List String )
    | QuerySucceed ( List String )
    | QueryFail Http.Error
