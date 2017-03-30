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
init = ( AppState "" Nothing, Cmd.none )

update : Msg -> AppState -> ( AppState, Cmd Msg )
update msg state =
    case msg of
        NoOp -> ( state, Cmd.none )
        UpdateQueryString newQueryString -> ( { state | queryString = newQueryString, queryResult = Nothing }, Cmd.none )
        SubmitQuery -> ( state, submitQuery state.queryString )
        QuerySucceed items -> ( { state | queryResult = Just items }, Cmd.none )
        QueryFail error -> ( state, Cmd.none )

postApi : String -> String
postApi query = "https://public-api.wordpress.com/rest/v1.1/sites/isthisbaokaka.wordpress.com/posts?fields=title&search=" ++ query

submitQuery : String -> Cmd Msg
submitQuery queryString =
    let
        processResult result =
            case result of
                Ok items -> QuerySucceed items
                Err error -> QueryFail error
    in
        Http.send processResult ( Http.get ( postApi queryString ) decodePostQueryResponse )

decodePostQueryResponse : Json.Decoder ( List String )
decodePostQueryResponse =
    Json.at [ "posts" ] ( Json.list ( Json.field "title" Json.string ) )
