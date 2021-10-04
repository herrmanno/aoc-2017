module Main where

import Lib

main :: IO ()
main = do
    as <- fmap parseAdapter . lines <$> getContents
    print $ solve1 as
    -- print $ solve2 as
