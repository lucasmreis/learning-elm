module Film exposing (Model, view, sample, filmDecoder)

import Html exposing (div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode.Extra exposing ((|:))
import Json.Decode exposing (Decoder, decodeValue, succeed, string, list, int, (:=))


type alias Model =
    { title : String
    , episode_id : Int
    , characters : List String
    }


filmDecoder : Decoder Model
filmDecoder =
    succeed Model
        |: ("title" := string)
        |: ("episode_id" := int)
        |: ("characters" := list string)


sample : Model
sample =
    { title = "A New Hope"
    , episode_id = 4
    , characters = [ "1", "2" ]
    }


view msg model =
    div
        [ onClick (msg model)
        , mainStyle
        ]
        [ div [ numberStyle ] [ text (toString model.episode_id) ]
        , div [ nameStyle ] [ text model.title ]
        ]


mainStyle =
    style
        [ ( "background-color", "rgba(52, 152, 219,1.0)" )
        , ( "width", "200px" )
        , ( "height", "200px" )
        , ( "color", "white" )
        , ( "font-family", "-apple-system, system, sans-serif" )
        , ( "margin", "20px 0px 0px 20px" )
        , ( "cursor", "pointer" )
        ]


nameStyle =
    style
        [ ( "padding", "20px" )
        , ( "font-size", "18px" )
        ]


numberStyle =
    style
        [ ( "padding", "20px 20px 0px 20px" )
        , ( "font-size", "60px" )
        ]
