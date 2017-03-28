module View exposing ( view )

-------------------------
-- External dependencies
-------------------------
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Html.Events exposing ( .. )

-------------------------
-- Internal dependencies
-------------------------
import Model exposing ( .. )

view : AppState -> Html Msg
view { queryString, queryStatus } =
    div
    [ class "isthisbaokaka__wrapper" ]
    [
        h2 [ class "isthisbaokaka__heading-text" ] [ text "這是寶卡卡嗎？" ],

        input
        [ class "isthisbaokaka__input-text-field"
        , type_ "text"
        , placeholder "請輸入建商大名..."
        , onInput UpdateQueryString
        ] [],

        button
        [ class "isthisbaokaka__main-button"
        , onClick SubmitQuery
        ] [ text "好緊張喔..." ]
    ]
