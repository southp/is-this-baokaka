module QueryApi exposing
    ( requestQuery
    )

-------------------------
-- External dependencies
-------------------------
import Http
import Json.Decode as Json


-- exclude the post ID 92 since it is the announcement post.
postApi : String -> String
postApi query = "https://public-api.wordpress.com/rest/v1.1/sites/isthisbaokaka.wordpress.com/posts?fields=title&exclude=92&search=" ++ query

decodePostQueryResponse : Json.Decoder ( List String )
decodePostQueryResponse =
    Json.at [ "posts" ] ( Json.list ( Json.field "title" Json.string ) )

requestQuery : String -> ( Result Http.Error ( List String ) -> msg ) -> Cmd msg
requestQuery queryString callback = Http.send callback ( Http.get ( postApi queryString ) decodePostQueryResponse )
