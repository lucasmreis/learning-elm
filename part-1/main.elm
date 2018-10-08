module Main exposing (..)

import Html exposing (text)
import String


type Value
    = Jack
    | Queen
    | King
    | Ace
    | Num Int


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


parseNumValue : String -> Maybe Value
parseNumValue v =
    case String.toInt v of
        Ok num ->
            if (num >= 2 && num <= 10) then
                Just (Num num)
            else
                Nothing

        Err _ ->
            Nothing


parseValue : String -> Maybe Value
parseValue v =
    case v of
        "J" ->
            Just Jack

        "Q" ->
            Just Queen

        "K" ->
            Just King

        "A" ->
            Just Ace

        _ ->
            parseNumValue v


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
    case ( Maybe.andThen parseValue value, Maybe.andThen parseSuit suit ) of
{--    case ( value `Maybe.andThen` parseValue, suit `Maybe.andThen` parseSuit ) of --}
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
    case value of
        Num 2 ->
            "Two"

        Num 3 ->
            "Three"

        Num 4 ->
            "Four"

        Num 5 ->
            "Five"

        Num 6 ->
            "Six"

        Num 7 ->
            "Seven"

        Num 8 ->
            "Eight"

        Num 9 ->
            "Nine"

        Num 10 ->
            "Ten"

        _ ->
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
    "JH"
        |> spellCard
        |> text
