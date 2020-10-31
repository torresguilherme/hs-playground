module FileIO (getMapFile) where

getMapFile :: FilePath -> IO String
getMapFile fileName = readFile fileName
