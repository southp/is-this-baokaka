module Update exposing
    ( init
    , update
    )

-------------------------
-- Internal dependencies
-------------------------
import Model exposing ( .. )
import QueryApi exposing ( requestQuery )

init : ( AppState, Cmd Msg )
init = ( AppState
    ""
    Nothing
    False
    Nothing
    Nothing
    , Cmd.none )

handleUpdateQueryString : String -> AppState -> ( AppState, Cmd Msg )
handleUpdateQueryString newQueryString state =
    if String.length( newQueryString ) == 1 then (
        { state | queryString = newQueryString, queryResult = Nothing },
        submitCandidateQuery newQueryString
    )
    else if String.length( newQueryString ) == 0 then (
        { state | queryString = newQueryString, candidates = Nothing },
        Cmd.none
    )
    else (
        { state | queryString = newQueryString, queryResult = Nothing },
        Cmd.none
    )

update : Msg -> AppState -> ( AppState, Cmd Msg )
update msg state =
    case msg of
        NoOp -> ( state, Cmd.none )
        UpdateQueryString newQueryString -> handleUpdateQueryString newQueryString state
        UpdateAndSubmit newQueryString -> (
            { state | queryString = newQueryString, isQuerying = True, queryResult = Nothing, queryError = Nothing, candidates = Nothing },
            submitQuery newQueryString
        )
        SubmitQuery -> (
            { state | isQuerying = True, queryResult = Nothing, queryError = Nothing, candidates = Nothing },
            submitQuery state.queryString
        )
        SubmitCandidateQuery -> (
            { state | isQuerying = True, candidates = Nothing, queryError = Nothing },
            Cmd.none
        )
        QuerySucceed items -> (
            { state | queryResult = Just items, isQuerying = False },
            Cmd.none
        )
        QueryCandidateSucceeded items -> (
            { state | candidates = Just items, isQuerying = False },
            Cmd.none
        )
        QueryFail error -> (
            { state | isQuerying = False, queryError = Just error },
            Cmd.none
        )

submitQuery : String -> Cmd Msg
submitQuery queryString =
    let
        processResult result =
            case result of
                Ok items -> QuerySucceed items
                Err error -> QueryFail error
    in
        requestQuery queryString processResult

submitCandidateQuery : String -> Cmd Msg
submitCandidateQuery queryString =
    let
        processResult result =
            case result of
                Ok items -> QueryCandidateSucceeded items
                Err error -> QueryFail error
    in
       requestQuery queryString processResult
