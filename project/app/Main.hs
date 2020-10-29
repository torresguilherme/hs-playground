module Main where

import FileIO
import System.Environment
import Train
import Generator

main :: IO ()
main = do {
    args <- getArgs;
    train <- head args;
    train_set_file <- if train then head (tail args) else Nothing;
}
