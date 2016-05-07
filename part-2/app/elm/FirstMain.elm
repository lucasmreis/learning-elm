module Main (..) where

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import StartApp.Simple exposing (start)
import String
import CardParser


main =
  StartApp.Simple.start
    { model = model
    , update = update
    , view = view
    }



-- MODEL


type alias Model =
  String


model =
  ""



-- UPDATE


type Action
  = ChangeText String


update : Action -> Model -> Model
update action model =
  case action of
    ChangeText s ->
      s



-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  let
    card =
      model
        |> String.trim
        |> CardParser.spellCard
  in
    div
      [ mainStyle ]
      [ input
          [ inputStyle
          , placeholder "Type your card..."
          , on "input" targetValue (ChangeText >> Signal.message address)
          ]
          []
      , p [ cardStyle ] [ text card ]
      ]


mainStyle : Attribute
mainStyle =
  style
    [ ( "padding", "40px" )
    , ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "align-items", "stretch" )
    , ( "background-color", "#fafafa" )
    , ( "border", "lightgray solid 1px" )
    ]


inputStyle : Attribute
inputStyle =
  style
    [ ( "border", "#fafafa solid" )
    , ( "border-bottom", "lightgray solid 1px" )
    , ( "font-size", "2em" )
    , ( "color", "rgba(0,0,0,0.87)" )
    , ( "background-color", "#fafafa" )
    ]


cardStyle : Attribute
cardStyle =
  style
    [ ( "align-self", "center" )
    , ( "font-size", "2em" )
    , ( "color", "rgba(0,0,0,0.87)" )
    ]
