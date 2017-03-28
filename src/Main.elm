module Main exposing ( .. )

-------------------------
-- External dependencies
-------------------------
import Html exposing ( program )

-------------------------
-- Internal dependencies
-------------------------
import Model exposing ( .. )
import View exposing ( .. )
import Update exposing ( .. )

main = program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }
