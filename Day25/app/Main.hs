module Main where

import Lib
import qualified Data.Set as S

main :: IO ()
main = print $ S.size . band $ states !! steps where
    states = iterate run emptyTuringMachine
    steps = 12302209
