module Update exposing
    ( init
    , update
    )
-------------------------
-- External dependencies
-------------------------
import Array as Array exposing ( .. )

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
    -1
    , Cmd.none )

handleUpdateQueryString : String -> AppState -> ( AppState, Cmd Msg )
handleUpdateQueryString newQueryString state =
    if String.length( newQueryString ) == 1 then (
        { state | queryString = newQueryString
        , queryResult = Nothing
        },
        submitCandidateQuery newQueryString
    )
    else if String.length( newQueryString ) == 0 then (
        { state | queryString = newQueryString
        , candidates = Nothing
        , candidateIndex = 0
        },
        Cmd.none
    )
    else (
        { state | queryString = newQueryString
        , queryResult = Nothing
        },
        Cmd.none
    )

safeGet : Int -> Array a -> a -> a
safeGet index array default =
    case Array.get index array of
        Just val -> val
        Nothing -> default

updateCandidateIndex : Msg -> AppState -> ( AppState, Cmd Msg )
updateCandidateIndex msg ( { candidates, candidateIndex } as state ) =
    case candidates of
        Just items ->
            case msg of
                IncreaseCandidateIndex ->
                    let
                        newIndex = min ( candidateIndex + 1 ) ( Array.length items - 1 )
                    in
                        ( { state | candidateIndex = newIndex, queryString = safeGet newIndex items "" }, Cmd.none )
                DecreaseCandidateIndex ->
                    let
                        newIndex = max ( candidateIndex - 1 ) 0
                    in
                        ( { state | candidateIndex = newIndex, queryString = safeGet newIndex items "" }, Cmd.none )
                _ -> ( state, Cmd.none )
        Nothing -> ( state, Cmd.none )


update : Msg -> AppState -> ( AppState, Cmd Msg )
update msg state =
    case msg of
        NoOp -> ( state, Cmd.none )
        UpdateQueryString newQueryString -> handleUpdateQueryString newQueryString state
        UpdateAndSubmit newQueryString -> (
            { state | queryString = newQueryString
            , isQuerying = True
            , queryResult = Nothing
            , queryError = Nothing
            , candidates = Nothing
            , candidateIndex = 0
            },
            submitQuery newQueryString
        )
        IncreaseCandidateIndex -> updateCandidateIndex msg state
        DecreaseCandidateIndex -> updateCandidateIndex msg state
        SubmitQuery -> (
            { state | isQuerying = True
            , queryResult = Nothing
            , queryError = Nothing
            , candidates = Nothing
            , candidateIndex = 0
            },
            submitQuery state.queryString
        )
        SubmitCandidateQuery -> (
            { state | isQuerying = True
            , candidates = Nothing
            , queryError = Nothing
            },
            Cmd.none
        )
        QuerySucceed items -> (
            { state | queryResult = Just items, isQuerying = False },
            Cmd.none
        )
        QueryCandidateSucceeded items -> (
            { state | candidates = Just ( Array.fromList items ), isQuerying = False },
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
