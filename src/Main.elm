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
                    ({model | tracks = tracks
                            , selected = firstOfEach tracks
                     }
                    , Cmd.none
                    )
                Err e ->
                    ({model | errMsg = Just (errorMessage e)}, Cmd.none)
        TrackClicked track ->
            ({model | selected = (replaceSelected model.selected track)
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
