module SafeCards exposing (..)

import Html exposing (text)
import String


type Value
    = Jack
    | Queen
    | King
    | Ace
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten


type Suit
    = Club
    | Diamond
    | Spade
    | Heart


type Card
    = OrdinaryCard Value Suit
    | Joker


parseSuit : Char -> Maybe Suit
parseSuit s =
    case s of
        'C' ->
            Just Club

        'D' ->
            Just Diamond

        'S' ->
            Just Spade

        'H' ->
            Just Heart

        _ ->
            Nothing


parseValue : String -> Maybe Value
parseValue v =
    case v of
        "2" ->
            Just Two

        "3" ->
            Just Three

        "4" ->
            Just Four

        "5" ->
            Just Five

        "6" ->
            Just Six

        "7" ->
            Just Seven

        "8" ->
            Just Eight

        "9" ->
            Just Nine

        "10" ->
            Just Ten

        "J" ->
            Just Jack

        "Q" ->
            Just Queen

        "K" ->
            Just King

        "A" ->
            Just Ace

        _ ->
            Nothing


divideCardString : String -> ( Maybe String, Maybe Char )
divideCardString str =
    let
        chars =
            String.toList str

        suit =
            chars
                |> List.reverse
                |> List.head

        value =
            chars
                |> List.reverse
                |> List.tail
                |> Maybe.map List.reverse
                |> Maybe.map String.fromList
    in
        ( value, suit )


parseCardTuple : ( Maybe String, Maybe Char ) -> Maybe Card
parseCardTuple ( value, suit ) =
    case ( value `Maybe.andThen` parseValue, suit `Maybe.andThen` parseSuit ) of
        ( Just v, Just s ) ->
            Just (OrdinaryCard v s)

        -- not a tuple
        _ ->
            Nothing


parseCardString : String -> Maybe Card
parseCardString str =
    case str of
        "J" ->
            Just Joker

        _ ->
            str
                |> divideCardString
                |> parseCardTuple


printSuit : Suit -> String
printSuit suit =
    toString suit


printValue : Value -> String
printValue value =
    toString value


printCard : Card -> String
printCard card =
    case card of
        OrdinaryCard value suit ->
            [ printValue value, " of ", printSuit suit ] |> String.concat

        Joker ->
            "Joker"


spellCard : String -> String
spellCard str =
    str
        |> parseCardString
        |> Maybe.map printCard
        |> Maybe.withDefault "-- unknown card --"


main : Html.Html a
main =
    "J"
        |> spellCard
        |> text
