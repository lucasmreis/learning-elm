module Main exposing (..)

import Html exposing (div, text, p)
import Html.Attributes exposing (style)
import Html.App
import Task
import Http
import Film
import Character


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type Model
    = InitialScreen
    | LoadingFilms Character.Model
    | LoadingCharacters Film.Model
    | FilmsFromCharacter Character.Model (List Film.Model)
    | CharactersFromFilm Film.Model (List Character.Model)


init : ( Model, Cmd Msg )
init =
    ( InitialScreen
    , getCharacter "http://swapi.co/api/people/1/"
    )



-- UPDATE


type Msg
    = LoadCharacters Film.Model
    | ToCharactersFromFilm Film.Model (List Character.Model)
    | LoadFilms Character.Model
    | ToFilmsFromCharacter Character.Model (List Film.Model)
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoadFilms ch ->
            ( LoadingFilms ch
            , getFilmsFromCharacter ch
            )

        ToFilmsFromCharacter c fs ->
            ( FilmsFromCharacter c fs
            , Cmd.none
            )

        LoadCharacters f ->
            ( LoadingCharacters f
            , getCharactersFromFilm f
            )

        ToCharactersFromFilm f chs ->
            ( CharactersFromFilm f chs
            , Cmd.none
            )

        _ ->
            ( model
            , Cmd.none
            )



-- VIEW


view : Model -> Html.Html Msg
view model =
    case model of
        InitialScreen ->
            loadingView "Loading amazing characters and films..."

        LoadingFilms ch ->
            div [ style [ ( "display", "flex" ) ] ]
                [ (Character.view LoadFilms ch)
                , loadingView ("Loading " ++ ch.name ++ " films...")
                ]

        FilmsFromCharacter ch fs ->
            div [ style [ ( "display", "flex" ) ] ]
                [ (Character.view LoadFilms ch)
                , div [] (List.map (Film.view LoadCharacters) fs)
                ]

        LoadingCharacters f ->
            div [ style [ ( "display", "flex" ) ] ]
                [ (Film.view LoadCharacters f)
                , loadingView ("Loading " ++ f.title ++ " characters...")
                ]

        CharactersFromFilm f chs ->
            div [ style [ ( "display", "flex" ) ] ]
                [ (Film.view LoadCharacters f)
                , div [] (List.map (Character.view LoadFilms) chs)
                ]


loadingView : String -> Html.Html a
loadingView t =
    div [ loadingStyle ] [ text t ]


loadingStyle =
    style
        [ ( "margin", "20px 0px 0px 20px" )
        , ( "width", "200px" )
        , ( "height", "200px" )
        , ( "font-family", "-apple-system, system, sans-serif" )
        , ( "color", "rgba(149, 165, 166,1.0)" )
        , ( "font-size", "18px" )
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTML


getCharacter : String -> Cmd Msg
getCharacter url =
    url
        |> (Http.get Character.characterDecoder)
        |> Task.perform FetchFail LoadFilms


getFilmsFromCharacter : Character.Model -> Cmd Msg
getFilmsFromCharacter ch =
    ch.films
        |> List.map (Http.get Film.filmDecoder)
        |> Task.sequence
        |> Task.perform FetchFail (ToFilmsFromCharacter ch)


getCharactersFromFilm : Film.Model -> Cmd Msg
getCharactersFromFilm f =
    f.characters
        |> List.map (Http.get Character.characterDecoder)
        |> Task.sequence
        |> Task.perform FetchFail (ToCharactersFromFilm f)
