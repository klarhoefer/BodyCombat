module Main exposing (..)


import Browser

import Common exposing (..)
import View exposing (view)

main : Program () Model Msg
main = Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }



init : () -> (Model, Cmd Msg)
init _ =
    (Model [], Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Noop -> (model, Cmd.none)
