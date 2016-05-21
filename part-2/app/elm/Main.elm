module Main exposing (..)

import Html.App exposing (beginnerProgram)
import Html exposing (div)
import ParserComponent exposing (Model, Msg, init, view, update)


main =
    Html.App.beginnerProgram
        { model = init "" ""
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { firstParser : ParserComponent.Model
    , secondParser : ParserComponent.Model
    }


init first second =
    Model first second



-- UPDATE


type Msg
    = First ParserComponent.Msg
    | Second ParserComponent.Msg


update msg model =
    case msg of
        First m ->
            { model | firstParser = ParserComponent.update m model.firstParser }

        Second m ->
            { model | secondParser = ParserComponent.update m model.secondParser }



-- VIEW


view model =
    div []
        [ Html.App.map First
            (ParserComponent.view model.firstParser)
        , Html.App.map Second
            (ParserComponent.view model.secondParser)
        ]
