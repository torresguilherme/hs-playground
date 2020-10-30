module Main where

import FileIO
import System.Environment
import Train
import Generator

import Options.Applicative

main :: IO ()
main = do {
  args <- getArgs;
  trainString <- head args;
  train <- boolFromString trainString;
  trainSetFile <- if (train == True) then head (tail args) else Nothing;
  wordMap <- if trainSetFile then (buildMap trainSetFile) else getMapFile;
  generate wordMap
}

boolFromString :: String -> Bool
boolFromString "False" = False
boolFromString _ = True
