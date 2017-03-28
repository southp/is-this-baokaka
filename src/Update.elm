module Update exposing ( .. )

import Model exposing ( .. )

init : ( AppState, Cmd Msg )
init = ( AppState "" 0, Cmd.none )

update : Msg -> AppState -> ( AppState, Cmd Msg )
update msg state =
    case msg of
        NoOp -> ( state, Cmd.none )
        UpdateQueryString newQueryString -> ( { state | queryString = newQueryString }, Cmd.none )
        SubmitQuery -> ( state, Cmd.none )
