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

init : ( AppState, Cmd Msg )
init = ( AppState "" 0, Cmd.none )

update : Msg -> AppState -> ( AppState, Cmd Msg )
update msg state =
    case msg of
        NoOp -> ( state, Cmd.none )
        UpdateQueryString newQueryString -> ( { state | queryString = newQueryString }, Cmd.none )
        SubmitQuery -> ( state, submitQuery state.queryString )
        QuerySucceed items -> ( state, Cmd.none )
        QueryFail error -> ( state, Cmd.none )


postApi : String
postApi = "https://public-api.wordpress.com/rest/v1.1/sites/isthisbaokaka.wordpress.com/posts"

submitQuery : String -> Cmd Msg
submitQuery queryString =
    let
        processResult result =
            case result of
                Ok items -> QuerySucceed items
                Err error -> QueryFail error
    in
        Http.send processResult ( Http.get postApi decodePostQueryResponse )

decodePostQueryResponse : Json.Decoder ( List String )
decodePostQueryResponse =
    Json.at [ "posts" ] ( Json.list Json.string )
