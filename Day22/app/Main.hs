module Main where

import Lib

main :: IO ()
main = do
    grid <- parseGrid <$> getContents
    print $  (solve1 grid) !! 10000
    print $  (solve2 grid) !! 10000000
