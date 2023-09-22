module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Common exposing (..)

view : Model -> Html Msg
view model =
    div []
        ((viewError model.errMsg) ++ (viewTracks model.tracks))

viewError : Maybe String -> List (Html Msg)
viewError err =
    case err of
        Just msg -> [ div [] [ text msg ]]
        Nothing -> []


viewTracks : List Track -> List (Html Msg)
viewTracks tracks =
    List.map viewTrack tracks


viewTrack : Track -> Html Msg
viewTrack track =
    div []
        [ text track.artist ]
