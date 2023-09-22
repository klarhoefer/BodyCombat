module View exposing (view)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Common exposing (..)


view : Model -> Html Msg
view model =
    div []
        [
            (case model.errMsg of
                Just err ->
                    div [] [ text err ]
                Nothing ->
                    div []
                        [ div []
                            (viewTracks model)
                        ]
            )
        ]


viewTracks : Model -> List (Html Msg)
viewTracks model =
    List.range 1 10
    |> List.map (\n -> viewTrackNumber n model)


viewTrackNumber : Int -> Model -> Html Msg
viewTrackNumber n model =
    let
        tracks =
            List.filter (\t -> t.track == n) model.tracks
            |> List.sortBy (\t -> -t.release)
    in
        div []
            [ h4 [] [ text <| "Track #" ++ (String.fromInt n) ]
            , div [ class "tracksN" ]
                (List.map viewTrack tracks)
            ]

releaseName : Float -> String
releaseName r =
    if r == 84.5 then
        "United"
    else
        String.fromFloat r


viewTrack : Track -> Html Msg
viewTrack track =
    div []
        [ text <| (releaseName track.release) ++ " " ++ track.artist ++ "/" ++ track.title 
        ]
