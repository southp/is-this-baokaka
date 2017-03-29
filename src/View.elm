module View exposing ( view )

-------------------------
-- External dependencies
-------------------------
import Html exposing ( .. )
import Html.Attributes exposing ( .. )
import Html.Events exposing ( .. )
import List

-------------------------
-- Internal dependencies
-------------------------
import Model exposing ( .. )

view : AppState -> Html Msg
view ( { queryString, queryResult } as state ) =
    div
    [ class "isthisbaokaka__main-wrapper" ]
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
        ] [ text "好緊張喔..." ],

        resultSection state
    ]

positiveResult : Html Msg
positiveResult =
    div [ class "isthisbaokaka__result-wrapper" ]
    [
       h3 [ class "isthisbaokaka__positive-result-text" ] [ text "此等霸氣，寶卡卡無誤！" ]
    ]

negativeResult : Html Msg
negativeResult =
    div [ class "isthisbaokaka__result-wrapper" ]
    [
        h3 [ class "isthisbaokaka__negative-result-text" ] [ text "應該不是，但所謂寶卡狡兔三窟，不妨再確認一下" ]
    ]

resultSection : AppState -> Html Msg
resultSection { queryString, queryResult } =
    case queryResult of
        Just items ->
            if List.member queryString items then
                positiveResult
            else
                negativeResult
        Nothing -> div [] []
