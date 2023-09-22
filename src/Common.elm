module Common exposing (..)


type Msg
    = Noop


type alias Track =
    { artist : String
    , title : String
    , release : Float
    , track : Int
    , seconds : Maybe Int
    }


type alias Model =
    { tracks : List Track
    }

