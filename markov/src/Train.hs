module Train where

type WordMap = ([String], [[Float]])

buildMap :: String -> IO WordMap
buildMap fileName = buildMatrixIO (getWords fileName) ([], [[]])

buildMatrixIO :: IO [String] -> WordMap -> IO WordMap
buildMatrixIO strings acc = flip buildMatrix acc <$> strings

buildMatrix :: [String] -> WordMap -> WordMap
buildMatrix [] acc = acc
buildMatrix [_:xs] acc = buildMatrix [xs] acc

getWords :: String -> IO [String]
getWords fileName = fmap words $ readFile fileName