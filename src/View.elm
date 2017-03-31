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

        Html.form
        [ action "#"
        , onSubmit SubmitQuery ]
        [
            input
            [ class "isthisbaokaka__input-text-field"
            , type_ "text"
            , placeholder "請輸入建商大名..."
            , autofocus True
            , onInput UpdateQueryString
            ] []
        ],
        queryStatusReportSection state,
        resultSection state
    ]

positiveResult : Html Msg
positiveResult =
    div [ class "isthisbaokaka__result-wrapper" ]
    [
       h3 [ class "isthisbaokaka__positive-result-text" ][ text "㊗️ 霸氣外露 ㊗️" ],
       h3 [ class "isthisbaokaka__positive-result-text" ][ text "㊗️ 寶卡無雙 ㊗️" ]
    ]

negativeResult : String -> Html Msg
negativeResult queryString =
    div [ class "isthisbaokaka__result-wrapper" ]
    [
        h3 [ class "isthisbaokaka__negative-result-text" ] [ text "🤖真可惜🤖" ],
        h3 [ class "isthisbaokaka__negative-result-text" ] [ text "🤖應該不是喔🤖" ],
        p [ class "isthisbaokaka__negative-result-description" ]
        [ text "不甘心？"
        , a [ href ( "https://www.google.com.tw/#q=" ++ queryString )
            , target "__blank"
            , rel "noopener noreferrer" ] [ text "Google" ]
        , text "確認一下！"
        ]
    ]

queryStatusReportSection : AppState -> Html Msg
queryStatusReportSection { isQuerying, queryError } =
    let
        contentElement =
            if isQuerying then
               div [ class "isthisbaokaka__status-report-loading-spinner" ] []
            else
                case queryError of
                    Just error ->
                        div [ class "isthisbaokaka__status-report-request-error-wrapper" ]
                        [
                            h3 [ class "isthisbaokaka__status-report-request-error-heading" ] [ text "不得了！伺服器出問題了！" ],
                            p [ class "isthisbaokaka__status-report-request-error-description" ] [ text "這通常是暫時性的，請稍候片刻再試一次。" ]
                        ]
                    Nothing -> span [] []
    in
        div [ class "isthisbaokaka__status-report-wrapper" ] [ contentElement ]


resultSection : AppState -> Html Msg
resultSection { queryString, queryResult } =
    case queryResult of
        Just items ->
            if List.member queryString items then
                positiveResult
            else
                negativeResult queryString
        Nothing -> div [] []
