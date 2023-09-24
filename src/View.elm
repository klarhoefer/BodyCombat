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
                    div [ class "outer" ]
                        [ table []
                            ((tr []
                                [ th [] [ text "#" ]
                                , th [] [ text "Title" ]
                                ]
                             ) :: (viewTracks model)
                            )
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
        tr []
            [ td [ style "text-align" "right" ] [ text <| String.fromInt n ]
            , if model.open /= n then
                td [] [viewSelectedTrack selected n]
              else
                td []
                    [ div [ class "tracksN" ]
                        (List.map viewTrack tracks)
                    ]
            ]


releaseName : Float -> String
releaseName r =
    if r == 84.5 then
        "United"
    else
        String.fromFloat r


viewTrack : Track -> Html Msg
viewTrack track =
    div [ onClick (TrackClicked track) ]
        [ text <| (releaseName track.release) ++ " " ++ track.artist ++ "/" ++ track.title 
        ]


viewSelectedTrack : Track -> Int -> Html Msg
viewSelectedTrack track n =
    div [ onClick (SelectedClicked n) ]
        [ text <| (releaseName track.release) ++ " " ++ track.artist ++ "/" ++ track.title 
        ]
