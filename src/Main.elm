module Main exposing (..)


import Browser

import Common exposing (..)
import Data exposing (loadTracks)
import View exposing (view)
import Data exposing (errorMessage)


addSeconds : Maybe Int -> Maybe Int -> Maybe Int
addSeconds a b =
    case (a, b) of
        (Just x, Just y) -> Just (x + y)
        _ -> Nothing


sumSeconds : List Track -> Maybe Int
sumSeconds tracks =
    tracks
    |> List.map (\t -> t.seconds)
    |> List.foldl addSeconds (Just 0)


main : Program () Model Msg
main = Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


init : () -> (Model, Cmd Msg)
init _ = (defaultModel, loadTracks)


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GotTracks loadRes ->
            case loadRes of
                Ok tracks ->
                    let
                        selected = firstOfEach tracks
                    in
                        ({model | tracks = tracks
                                , selected = selected
                                , seconds = sumSeconds selected
                        }
                        , Cmd.none
                        )
                Err e ->
                    ({model | errMsg = Just (errorMessage e)}, Cmd.none)
        TrackClicked track ->
            let
                selected = replaceSelected model.selected track
            in
                ({model | selected = selected
                        , seconds = sumSeconds selected
                        , open = 0
                }
                , Cmd.none
                )
        SelectedClicked n ->
            ({model | open = n}
            , Cmd.none
            )


firstOfEach : List Track -> List Track
firstOfEach tracks =
    List.range 1 10
    |> List.map (\n -> firstOf n tracks)


firstOf : Int -> List Track -> Track
firstOf n tracks =
    tracks
    |> List.filter (\t -> t.track == n)
    |> List.sortBy (\t -> -t.release)
    |> List.head
    |> Maybe.withDefault defaultTrack


replaceSelected : List Track -> Track -> List Track
replaceSelected tracks track =
    case tracks of
        [] -> []
        t :: h ->
            if t.track == track.track then
                track :: h
            else
                t :: (replaceSelected h track)
