module Main where

import FileIO
import Train
import Generator

import Options.Applicative
import Data.Semigroup((<>))

data Args = Sample {
    train :: Bool,
    trainFile :: String
    -- modelFile :: String
}

args :: Parser Args
args = Sample 
    <$> switch (
        long "train"
        <> help "whether to train the model or not" )
    <*> strOption ( 
        long "trainFile"
        <> metavar "TARGET"
        <> help "file with training data" )
    -- <*> strOption ( 
    --     long "modelFile"
    --     <> metavar "TARGET"
    --     <> help "file with training data" )

optsParser :: ParserInfo Args
optsParser = info (args <**> helper)
      ( fullDesc
     <> progDesc "Print a greeting for TARGET"
     <> header "hello - a test for optparse-applicative" )

main :: IO ()
main = do {
    args <- execParser optsParser;
    -- wordMap <- if (train args) then (buildMap (trainFile args)) else getMapFile (modelFile args);
    putStrLn "Training model...";
    wordMap <- buildMap (trainFile args);
    putStrLn "Generating sequence...";
    putStrLn "oi"
}
