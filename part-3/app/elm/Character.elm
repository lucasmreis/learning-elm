module Character exposing (..)

import Html exposing (div, text)
import Html.Attributes exposing (style)


type alias Model =
    { name : String
    }


view model =
    div [ mainStyle ]
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
