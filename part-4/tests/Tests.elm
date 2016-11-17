module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (..)
import Cards exposing (..)


all : Test
all =
    describe "parseNumValue"
        [ test "cannot be less than 2"
            <| \() -> Expect.equal (parseNumValue "1") Nothing
        , test "minimum of 2"
            <| \() -> Expect.equal (parseNumValue "2") (Just (Num 2))
        , test "maximum of 10"
            <| \() -> Expect.equal (parseNumValue "10") (Just (Num 10))
        , test "cannot be more than 10"
            <| \() -> Expect.equal (parseNumValue "11") Nothing
        , fuzz int "parseNumValue"
            <| \number ->
                let
                    parsed =
                        number
                            |> toString
                            |> parseNumValue
                in
                    case parsed of
                        Just (Num v) ->
                            Expect.true "Number should be >= 2 and <= 10 when Just Num v"
                                (v >= 2 && v <= 10)

                        _ ->
                            Expect.false "Number should not be >= 2 and <= 10 when Nothing"
                                (number >= 2 && number <= 10)
        ]
