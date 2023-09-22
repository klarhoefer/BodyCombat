module Data exposing (loadTracks, errorMessage)

import Http
import Json.Decode exposing (..)

import Common exposing (..)


errorMessage : Http.Error -> String
errorMessage e =
    case e of
        Http.BadBody b -> b
        Http.BadStatus s -> "Status " ++ (String.fromInt s)
        Http.BadUrl u -> "URL " ++ u
        Http.NetworkError -> "Network error"
        Http.Timeout -> "Operation timed out"


loadTracks : Cmd Msg
loadTracks =
    Http.get
        { url = "http://klarhoefer.lima-city.de/bodycombatjson.php"
        , expect = Http.expectJson GotTracks trackListDecoder
        }


trackListDecoder : Decoder (List Track)
trackListDecoder = list trackDecoder


trackDecoder : Decoder Track
trackDecoder =
    map5 Track
        (field "artist" string)
        (field "title" string)
        (field "release" float)
        (field "track" int)
        (field "seconds" (maybe int))
