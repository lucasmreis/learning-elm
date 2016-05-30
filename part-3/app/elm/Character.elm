module Character exposing (Model, sample, view, characterDecoder)

import Html exposing (div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)
import Json.Decode.Extra exposing ((|:))
import Json.Decode exposing (Decoder, decodeValue, succeed, string, list, int, (:=))


type alias Model =
    { name : String
    , films : List String
    }


characterDecoder : Decoder Model
characterDecoder =
    succeed Model
        |: ("name" := string)
        |: ("films" := list string)


sample : Model
sample =
    { name = "Luke Skywalker"
    , films = [ "3", "4", "5" ]
    }


view msg model =
    div
        [ onClick (msg model)
        , mainStyle
        ]
        [ div [ nameStyle ] [ text model.name ] ]


mainStyle =
    style
        [ ( "background-color", "rgba(230, 126, 34,1.0)" )
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
