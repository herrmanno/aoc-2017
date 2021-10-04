{-# LANGUAGE RecordWildCards #-}
module Lib where

import qualified Data.Set as S

type Band = S.Set Int

data State = A | B | C | D | E | F

data TuringMachine = TuringMachine { band :: Band, pointer :: Int, state :: State }

emptyTuringMachine = TuringMachine S.empty 0 A

run :: TuringMachine -> TuringMachine
run TuringMachine {..} = case (state, S.member pointer band) of
    (A,False) -> TuringMachine write1 moveRight B
    (A,True) ->  TuringMachine write0 moveLeft D

    (B,False) -> TuringMachine write1 moveRight C
    (B,True) ->  TuringMachine write0 moveRight F

    (C,False) -> TuringMachine write1 moveLeft C
    (C,True) ->  TuringMachine band   moveLeft A

    (D,False) -> TuringMachine band   moveLeft E
    (D,True) ->  TuringMachine band   moveRight A

    (E,False) -> TuringMachine write1 moveLeft A
    (E,True) ->  TuringMachine write0 moveRight B

    (F,False) -> TuringMachine band   moveRight C
    (F,True) ->  TuringMachine write0 moveRight E
    where
        write1 = S.insert pointer band
        write0 = S.delete pointer band
        moveRight = succ pointer
        moveLeft = pred pointer
