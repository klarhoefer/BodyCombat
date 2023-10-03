module View exposing (view)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Common exposing (..)


releaseName : Float -> String
releaseName r =
    if r == 84.5 then
        "Utd"
    else
        String.fromFloat r


nth : Int -> List x -> Maybe x
nth n l =
    case l of
        [] -> Nothing
        h :: t ->
            if n == 1 then
                Just h
            else
                nth (n - 1) t


minutes : Maybe Int -> String
minutes seconds =
    case seconds of
        Nothing -> "-.--"
        Just n ->
            let
                secs = modBy 60 n
                mins = (n - secs) // 60
                pad = if secs < 10 then "0" else ""
            in
                (String.fromInt mins) ++ ":" ++ pad ++ (String.fromInt secs)


view : Model -> Html Msg
view model =
    div []
        [
            (case model.errMsg of
                Just err ->
                    div [] [ text <| "Error: " ++ err ]
                Nothing ->
                    div [ class "outer" ]
                        [ table []
                            (((tr []
                                [ th [ style "text-align" "right" ] [ text "#" ]
                                , th [ colspan 3 ] [ text "Title" ]
                                ]
                             ) :: (viewTracks model)
                            ) ++ [ tr []
                                    [ th [ colspan 3, style "text-align" "right", style "padding-right" "8px" ] [ text "Total" ]
                                    , th [ style "text-align" "right" ] [ text <| minutes model.seconds ]
                                    ]
                                ]
                            )
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
        selected = nth n model.selected |> Maybe.withDefault defaultTrack
    in
        tr (if model.open /= n then [ onClick (SelectedClicked n) ] else [])
            <| (td [ style "text-align" "right" ] [ text <| String.fromInt n ])
            ::
            (if model.open /= n then
                (viewSingleTrack selected)
              else
                [ td [ colspan 3 ]
                    [ div [ class "tracksN" ]
                        [ table []
                            (List.map viewTrack tracks)
                        ]
                    ]
                ]
            )

viewSingleTrack : Track -> List (Html Msg)
viewSingleTrack track =
    [ td [ style "text-align" "right", style "padding-left" "8px", style "padding-right" "8px" ] [ text <| releaseName track.release ]
    , td [] [ text track.title ]
    , td [ style "text-align" "right" ] [ text <| minutes track.seconds]
    ]


viewTrack : Track -> Html Msg
viewTrack track =
    tr [ onClick (TrackClicked track) ]
        (viewSingleTrack track)
