{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE NamedFieldPuns #-}
module Lib where

import Data.List (tails, unfoldr, sortOn, groupBy, find, minimumBy)
import Data.Maybe (listToMaybe, fromMaybe, fromJust)
import Text.Printf (PrintfArg(parseFormat))
import Data.Function (on)
import Data.Ord (comparing)

solve1 :: System -> Int
solve1 s = fst $ minimumBy (comparing snd) (zip [0..] s)

solve2 :: System -> System
solve2 s = fromJust $ find (all isFinal) $ iterate (destroyCollided . fmap move) (destroyCollided s)

type Triple = [Int]

data Particle = Particle { pos :: Triple, veloc :: Triple, accel :: Triple } deriving (Show,Eq)

instance Ord Particle where
    a <= b = distance a <= distance b

distance :: Particle -> Int
distance Particle{..} = sum (map abs accel)

decreases :: Particle -> Bool
decreases p = move p < p

isFinal :: Particle -> Bool
isFinal Particle{..} = and (zipWith isOkay pos veloc) && and (zipWith isOkay veloc accel) where
    isOkay a b = 0 == b || signum a == signum b

move :: Particle -> Particle
move Particle{..} = let veloc' = zipWith (+) veloc accel
                        pos' = zipWith (+) pos veloc'
                    in Particle pos' veloc' accel

type System = [Particle]

destroyCollided :: System -> System
destroyCollided = concat . filter ((<2) . length) . groupBy ((==) `on` pos) . sortOn pos

parseParticle :: String -> Particle
parseParticle = go . parseNumbers where
    go [px,py,pz,vx,vy,vz,ax,ay,az] = Particle [px, py, pz] [vx,vy,vz] [ax,ay,az]
    go _ = error "Could not parse particle"

parseNumbers :: String -> [Int]
parseNumbers = unfoldr $ listToMaybe . concatMap reads . tails
