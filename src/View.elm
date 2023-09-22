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


nth : Int -> List x -> Maybe x
nth n l =
    case l of
        [] -> Nothing
        h :: t ->
            if n == 1 then
                Just h
            else
                nth (n - 1) t


viewTrackNumber : Int -> Model -> Html Msg
viewTrackNumber n model =
    let
        tracks =
            List.filter (\t -> t.track == n) model.tracks
            |> List.sortBy (\t -> -t.release)
        selected = nth n model.selected |> Maybe.withDefault defaultTrack
    in
        div []
            [ h4 [] [ text <| "Track #" ++ (String.fromInt n) ]
            , (viewTrack selected)
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
