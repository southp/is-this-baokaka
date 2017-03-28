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
    div []
    [
        h2 [] [ text "這是寶卡卡嗎？" ],
        input [ type_ "text", placeholder "輸入建商大名", onInput UpdateQueryString ] [],
        button [ onClick SubmitQuery ] [ text "好緊張喔..." ]
    ]
