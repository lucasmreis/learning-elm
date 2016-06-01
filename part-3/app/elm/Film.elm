module Film exposing (..)

import Html exposing (div, text)
import Html.Attributes exposing (style)


type alias Model =
    { title : String
    , episode_id : Int
    }


view model =
    let
        chapter =
            toString model.episode_id
    in
        div [ mainStyle ]
            [ div [ numberStyle ]
                [ text chapter ]
            , div [ nameStyle ]
                [ text model.title ]
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
