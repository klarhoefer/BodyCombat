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

defaultTrack : Track
defaultTrack = Track "" "" 0 0 Nothing


type alias Model =
    { tracks : List Track
    , errMsg : Maybe String
    , selected : List Track
    , open : Int
    }

defaultModel : Model
defaultModel = Model [] Nothing [] 0
