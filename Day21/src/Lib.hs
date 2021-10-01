module Lib where

import qualified Data.Map as M
import Data.List.Split (splitOn, chunksOf)
import Data.List (transpose)
import Data.Maybe (mapMaybe)

someFunc = putStrLn "someFunc"

type Pattern = [[Char]]

type Rule = (Pattern, Pattern)

type Rules = M.Map Pattern Pattern

parseRule :: String -> Rule
parseRule s = let [from,_,to] = words s in (splitOn "/" from, splitOn "/" to)

parseRules :: String -> Rules
parseRules = M.fromList . fmap parseRule . lines

flipAndRotate p = take 4 (iterate rotate p) >>= \p -> [p, flip p] where
    flip = fmap reverse
    rotate = transpose . fmap reverse

evolvePattern :: Rules -> Pattern -> Pattern
evolvePattern r p
    | length p == 2 = applyPattern r p
    | length p == 3 = applyPattern r p
    | even (length p) = joinPatterns (applyPattern r <$> splitPatternN 2 p)
    | length p `mod` 3 == 0 = joinPatterns (applyPattern r <$> splitPatternN 3 p)
    | otherwise = error $ "Bad pattern size: " <> show (length p)

applyPattern :: Rules -> Pattern -> Pattern
applyPattern r p = case mapMaybe (`M.lookup` r) (flipAndRotate p) of
                        (p':_) -> p'
                        _ -> error $ "Bad pattern: " <> show p

splitPatternN :: Int -> Pattern -> [Pattern]
splitPatternN n p | n == length p = [fmap (take n) p, fmap (drop n) p]
splitPatternN n p = go (chunksOf n p) where
    go [] = []
    go (x:xs) = zip' x ++ go xs
    zip' [] = []
    zip' ([]:_) = []
    zip' xs = let l = length xs in fmap (take l) xs : zip' (fmap (drop l) xs)

joinPatterns :: [Pattern] -> Pattern
-- joinPatterns ps = let l = round (sqrt $ fromIntegral (length ps))
                      -- join = fmap concat . transpose
                  -- in concatMap join (chunksOf l ps)
joinPatterns ps = concatMap join (chunksOf l ps) where
    l = round (sqrt $ fromIntegral (length ps))
    join = fmap concat . transpose
                  
