module Update exposing
    ( init
    , update
    )

-------------------------
-- External dependencies
-------------------------
import Http
import Json.Decode as Json

-------------------------
-- Internal dependencies
-------------------------
import Model exposing ( .. )
import QueryApi exposing ( requestQuery )

init : ( AppState, Cmd Msg )
init = ( AppState "" Nothing False Nothing, Cmd.none )


handleUpdateQueryString : String -> AppState -> ( AppState, Cmd Msg )
handleUpdateQueryString newQueryString state = (
        { state | queryString = newQueryString, queryResult = Nothing },
        Cmd.none
    )

update : Msg -> AppState -> ( AppState, Cmd Msg )
update msg state =
    case msg of
        NoOp -> ( state, Cmd.none )
        UpdateQueryString newQueryString -> handleUpdateQueryString newQueryString state
        SubmitQuery -> (
            { state | isQuerying = True, queryResult = Nothing, queryError = Nothing },
            submitQuery state.queryString
        )
        QuerySucceed items -> (
            { state | queryResult = Just items, isQuerying = False },
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
