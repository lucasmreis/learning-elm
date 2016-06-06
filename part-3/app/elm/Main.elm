module Main exposing (..)

import Html exposing (div, text)
import Html.Attributes exposing (style)
import Html.App
import Http
import Task
import Character
import Film


main =
    Html.App.program
        { init = ( InitialScreen, getCharacter "http://swapi.co/api/people/1/" )
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL
-- Aliases added for reading simplicity


type alias C =
    Character.Model


type alias F =
    Film.Model


type Model
    = InitialScreen
    | ErrorScreen
    | WaitingForFilms C
    | WaitingForCharacters F
    | FilmsFromCharacter C (List F)
    | CharactersFromFilm F (List C)



-- UPDATE


type Msg
    = LoadFilms C
    | LoadCharacters F
    | FetchFail Http.Error
    | ToFilmsFromCharacter C (List F)
    | ToCharactersFromFilm F (List C)


update msg model =
    case msg of
        FetchFail _ ->
            ( ErrorScreen, Cmd.none )

        LoadFilms c ->
            ( WaitingForFilms c, getFilmsFromCharacter c )

        ToFilmsFromCharacter c fs ->
            ( FilmsFromCharacter c fs, Cmd.none )

        LoadCharacters f ->
            ( WaitingForCharacters f, getCharactersFromFilm f )

        ToCharactersFromFilm f cs ->
            ( CharactersFromFilm f cs, Cmd.none )



-- VIEW


msgMap =
    Html.App.map


view model =
    case model of
        InitialScreen ->
            simpleMessage "Loading amazing characters and films..."

        ErrorScreen ->
            simpleMessage "Sorry, there was an error. Please try again!"

        WaitingForFilms c ->
            div [ twoColumns ]
                [ msgMap LoadFilms (Character.view c)
                , simpleMessage "Loading Films..."
                ]

        FilmsFromCharacter c fs ->
            let
                filmsViews =
                    fs
                        |> List.map Film.view
                        |> List.map (msgMap LoadCharacters)
            in
                div [ twoColumns ]
                    [ msgMap LoadFilms (Character.view c)
                    , div [] filmsViews
                    ]

        WaitingForCharacters f ->
            div [ twoColumns ]
                [ msgMap LoadCharacters (Film.view f)
                , simpleMessage "Loading Characters..."
                ]

        CharactersFromFilm f cs ->
            let
                charactersViews =
                    cs
                        |> List.map Character.view
                        |> List.map (msgMap LoadFilms)
            in
                div [ twoColumns ]
                    [ msgMap LoadCharacters (Film.view f)
                    , div [] charactersViews
                    ]


twoColumns =
    style [ ( "display", "flex" ) ]


simpleMessage t =
    div [ simpleMessageStyle ] [ text t ]


simpleMessageStyle =
    style
        [ ( "margin", "20px 0px 0px 20px" )
        , ( "width", "200px" )
        , ( "height", "200px" )
        , ( "font-family", "-apple-system, system, sans-serif" )
        , ( "color", "rgba(149, 165, 166,1.0)" )
        , ( "font-size", "18px" )
        ]



-- SUBSCRIPTIONS


subscriptions x =
    Sub.none



-- HTTP


getCharacter url =
    url
        |> Http.get Character.characterDecoder
        |> Task.perform FetchFail LoadFilms


getFilmsFromCharacter : Character.Model -> Cmd Msg
getFilmsFromCharacter c =
    c.films
        |> List.map (Http.get Film.filmDecoder)
        |> Task.sequence
        |> Task.perform FetchFail (ToFilmsFromCharacter c)


getCharactersFromFilm : Film.Model -> Cmd Msg
getCharactersFromFilm f =
    f.characters
        |> List.map (Http.get Character.characterDecoder)
        |> Task.sequence
        |> Task.perform FetchFail (ToCharactersFromFilm f)
