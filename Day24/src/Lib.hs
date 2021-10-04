{-# LANGUAGE BangPatterns #-}
module Lib where

import Data.List (unfoldr, tails)
import Data.Maybe (listToMaybe)
import Control.Arrow (second, (&&&))

solve1 = maximum . fmap sumAdapters . findBridges 0

solve2 = snd . maximum . fmap (length &&& sumAdapters) . findBridges 0

type Adapter = (Int,Int)

match n (a,b)
    | n == a = Just b
    | n == b = Just a
    | otherwise = Nothing

sumAdapter (a,b) = a + b
sumAdapters = sum . fmap sumAdapter

parseAdapter :: String -> Adapter
parseAdapter = f . parseNumbers where
    f [a,b] = (a,b)
    f _ = undefined

parseNumbers :: String -> [Int]
parseNumbers = unfoldr $ listToMaybe . concatMap reads . tails

findBridges :: Int -> [Adapter] -> [[Adapter]]
findBridges _ [] = [[]]
findBridges n as = do
    (a,as') <- pick as
    case match n a of
      (Just b) -> let rest = findBridges b as'
                  in fmap (a:) (if null rest then [[]] else rest)
      Nothing -> []

pick :: [a] -> [(a, [a])]
pick [] = []
pick (x:xs) = (x,xs) : fmap (second (x:)) (pick xs)

