module Main exposing (..)

import Html exposing (div)
import Html.Attributes exposing (style)
import Html.App
import Character
import Film


main =
    Html.App.beginnerProgram
        { model = model
        , view = view
        , update = update
        }



-- MODEL
-- Aliases added for reading simplicity


type alias C =
    Character.Model


type alias F =
    Film.Model


type Model
    = FilmsFromCharacter C (List F)
    | CharactersFromFilm F (List C)



-- SAMPLE


update model =
    model


sampleCh : Character.Model
sampleCh =
    { name = "Luke Skywalker"
    }


sampleFilm : Film.Model
sampleFilm =
    { title = "A New Hope"
    , episode_id = 4
    }


model =
    FilmsFromCharacter sampleCh
        [ sampleFilm
        , sampleFilm
        , sampleFilm
        ]


view model =
    case model of
        FilmsFromCharacter c fs ->
            div [ style [ ( "display", "flex" ) ] ]
                [ Character.view c
                , div [] (List.map Film.view fs)
                ]

        CharactersFromFilm f cs ->
            div [ style [ ( "display", "flex" ) ] ]
                [ Film.view f
                , div [] (List.map Character.view cs)
                ]
