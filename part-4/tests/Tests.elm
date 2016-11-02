module Tests exposing (..)

import Test exposing (..)
import Expect
import Fuzz exposing (..)
import Cards exposing (..)


all : Test
all =
    fuzz (intRange -20 20) "parseNumValue"
        <| \number ->
            let
                parsed =
                    parseNumValue (toString number)
            in
                case parsed of
                    Just (Num v) ->
                        Expect.true "Number should be >= 2 and <= 10 when Just Num v"
                            (v >= 2 && v <= 10)

                    _ ->
                        Expect.false "Number should not be >= 2 and <= 10 when Nothing"
                            (number >= 2 && number <= 10)
