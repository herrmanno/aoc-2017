module Main where

import Lib

main :: IO ()
main = do
    ps <- fmap parseParticle . lines <$> getContents
    print (solve1 ps)
    print (length $ solve2 ps)
