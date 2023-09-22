module Common exposing (..)

import Http


type Msg
    = GotTracks (Result Http.Error (List Track))


type alias Track =
    { artist : String
    , title : String
    , release : Float
    , track : Int
    , seconds : Maybe Int
    }


type alias Model =
    { tracks : List Track
    , errMsg : Maybe String
    }

