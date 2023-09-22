module Main exposing (..)


import Browser

import Common exposing (..)
import Data exposing (loadTracks)
import View exposing (view)
import Data exposing (errorMessage)


main : Program () Model Msg
main = Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


init : () -> (Model, Cmd Msg)
init _ =
    (Model [] Nothing, loadTracks)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotTracks loadRes ->
            case loadRes of
                Ok tracks ->
                    ({model | tracks = tracks}, Cmd.none)
                Err e ->
                    ({model | errMsg = Just (errorMessage e)}, Cmd.none)
