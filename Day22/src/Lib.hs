{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TupleSections #-}
{-# LANGUAGE BangPatterns #-}
module Lib where

import qualified Data.Map as M
import Control.Arrow (first, second)
import Data.Maybe (isNothing)

type Pos = (Int,Int)

type Grid = M.Map Pos NodeState

data Dir = U | R | D | L deriving (Show,Eq,Enum,Bounded)

turnLeft :: Dir -> Dir
turnLeft U = L
turnLeft d = pred d

turnRight :: Dir -> Dir
turnRight L= U
turnRight d = succ d

turnAround :: Dir -> Dir
turnAround = turnLeft . turnLeft

move :: Dir -> Pos -> Pos
move U = first (subtract 1)
move D = first (+ 1)
move L = second (subtract 1)
move R = second (+ 1)

data NodeState = Clean | Weakened | Infected | Flagged deriving (Show,Eq)

fromChar '.' = Clean
fromChar '#' = Infected
fromChar c = error $ "Bad node state: " <> [c]

data State = State { grid :: !Grid, pos :: !Pos, dir :: !Dir } deriving (Show)

toInitialState g = State g(0,0) U

solve1 :: Grid -> [Int]
solve1 = solve burstMode1

solve2 :: Grid -> [Int]
solve2 = solve burstMode2

solve :: BurstMode -> Grid -> [Int]
solve bm = map fst . iterate it . (0,) . toInitialState  where
    it (!n, !s) = first (+n) $ burst bm s 

type BurstMode = Maybe NodeState -> Maybe NodeState

burstMode1 (Just Infected) = Nothing
burstMode1 _ = Just Infected

burstMode2 (Just Weakened) = Just Infected
burstMode2 (Just Infected) = Just Flagged
burstMode2 (Just Flagged) = Nothing
burstMode2 _ = Just Weakened

burst :: BurstMode -> State -> (Int, State)
burst f State{..} =
    case M.findWithDefault Clean pos grid of
        Clean ->    let dir' = turnLeft dir     in (gotInfected, State grid' (move dir' pos) dir')
        Weakened -> let dir' = dir              in (gotInfected, State grid' (move dir' pos) dir')
        Infected -> let dir' = turnRight dir    in (gotInfected, State grid' (move dir' pos) dir')
        Flagged ->  let dir' = turnAround dir   in (gotInfected, State grid' (move dir' pos) dir')
    where
        pos' = move dir pos
        (gotInfected, grid') =
            let node = f (M.lookup pos grid)
            in (fromEnum $ node == Just Infected, M.alter (const node) pos grid)

parseGrid :: String -> Grid
parseGrid s = M.fromList list where
    list = [ ((y - offset,x - offset), fromChar char)
           | (y,line) <- zip [0..] (lines s)
           , (x,char) <- zip [0..] line
           ]
    offset = length (head (lines s)) `div` 2
