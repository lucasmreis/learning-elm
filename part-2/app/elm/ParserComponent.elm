module ParserComponent exposing (Model, Msg, init, view, update)

import Html exposing (div, input, p, text)
import Html.Attributes exposing (style, placeholder)
import Html.Events exposing (onInput)
import String
import CardParser exposing (spellCard)


-- MODEL


type alias Model =
    String


init : String -> Model
init str =
    str



-- UPDATE


type Msg
    = ChangeText String


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangeText newText ->
            newText



-- VIEW


sentence card =
    p [ cardStyle ] [ text card ]


view model =
    let
        cards =
            model
                |> String.split ","
                |> List.map String.trim
                |> List.map CardParser.spellCard
    in
        div [ mainStyle ]
            [ input
                [ inputStyle
                , placeholder "Type your card..."
                , onInput ChangeText
                ]
                []
            , div [] (List.map sentence cards)
            ]


mainStyle =
    style
        [ ( "font-family", "-apple-system, system, sans-serif" )
        , ( "margin", "10px" )
        , ( "padding", "40px" )
        , ( "display", "flex" )
        , ( "flex-direction", "column" )
        , ( "align-items", "stretch" )
        , ( "background-color", "#fafafa" )
        , ( "border", "lightgray solid 1px" )
        ]


inputStyle =
    style
        [ ( "border", "#fafafa solid" )
        , ( "border-bottom", "lightgray solid 1px" )
        , ( "font-size", "2em" )
        , ( "color", "rgba(0,0,0,0.75)" )
        , ( "background-color", "#fafafa" )
        ]


cardStyle =
    style
        [ ( "font-size", "2em" )
        , ( "color", "rgba(0,0,0,0.75)" )
        ]
