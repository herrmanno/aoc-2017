module Main where

import Lib
import qualified Data.Map as M

main :: IO ()
main = do
    commands <- fmap words . lines <$> getContents
    print $ mulTimesCalled commands
    -- let regs = M.insert "a" 1 emptyRegister
    -- print $ runAll regs commands
