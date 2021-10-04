{-# LANGUAGE RankNTypes #-}
module Lib where

import qualified Data.Map as M
import Data.List (intercalate)
import Debug.Trace

type Registers = M.Map String Integer

emptyRegister = M.fromList (zip (fmap (:[]) "abcdefgh") (repeat 0))

type Command = [String]

run :: Int -> Registers -> Command -> (Int, Registers)
run ip r xs = case xs of
    ["set", x, y] -> (ip + 1, M.insert x (get y) r)
    ["sub", x, y] -> (ip + 1, M.adjust (subtract (get y)) x r)
    ["mul", x, y] -> (ip + 1, M.adjust (* get y) x r)
    ["jnz", x, y]
      | (get x) /= 0 -> (ip + fromIntegral (get y), r)
      | otherwise -> (ip + 1, r)
    _ -> error $ "Bad command: " <> unwords xs
    where
        get y = M.findWithDefault (read y) y r

mulTimesCalled :: [Command] -> Int
mulTimesCalled cs = next 0 emptyRegister  where
    next ip r 
      | ip < 0 || ip >= length cs = 0
      | otherwise = go ip r (cs !! ip)
    go ip reg cmd@["mul", _, _] = let (ip', reg') = run ip reg cmd in 1 + next ip' reg'
    go ip reg cmd = let (ip', reg') = run ip reg cmd in next ip' reg'

type Debugger m = (Monad m) => Int -> Command -> Registers -> m ()

runAll :: (Monad m) => Debugger m -> Registers -> [Command] -> m Registers
runAll dbg registers cs = next 0 registers  where
    next ip r 
      | ip < 0 || ip >= length cs = return r
      | otherwise = go ip r (cs !! ip)
    go ip reg cmd = let (ip', reg') = run ip reg cmd in dbg ip cmd reg >> next ip' reg'

debugger ip cmd reg = do
    putStr $ show ip <> "\t" <> unwords cmd <> "\t"
    putStr $ intercalate ", " $ fmap (\(k,v) -> show k <> ": " <> show v) (M.toList reg)
    getLine
    return ()

-- noop :: Debugger Identity
-- noop _ _ _ = return ()
