module Main exposing ( .. )

import Html exposing ( program )

import Model exposing ( .. )
import View exposing ( .. )
import Update exposing ( .. )

main = program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }
