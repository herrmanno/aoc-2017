module Main where

import Lib

main :: IO ()
main = do
    rules <- parseRules <$> getContents
    let result = iterate (evolvePattern rules) startPattern
    print $ length $ filter (=='#') (concat $ result !! 5)
    print $ length $ filter (=='#') (concat $ result !! 18)

startPattern = [ ".#.", "..#", "###" ]
