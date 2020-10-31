module Train where

import Data.Map as Map

type Source = String
type Target = String
type TargetFrequency = (Target, Rational)
type Transitions = [(Source, Target)]
type WordMap = Map.Map Source [TargetFrequency]

buildMap :: String -> IO WordMap
buildMap fileName = buildMatrixIO (getWords fileName)

buildMatrixIO :: IO [String] -> IO WordMap
buildMatrixIO strings = buildMatrix <$> strings

buildMatrix :: [String] -> WordMap
buildMatrix strings = addTargets (getTransitions strings)

getTransitions :: [String] -> Transitions
getTransitions (s:ss) = zip ("":ws) ws ++ getTransitions ss
    where ws = words s
getTransitions _ = []

addTargets :: Transitions -> WordMap
addTargets  = Prelude.foldr insert Map.empty where
    insert t = Map.insertWith addTargetFs (fst t) [(snd t, 1.0)]

addTargetFs :: [TargetFrequency] -> [TargetFrequency] -> [TargetFrequency]
addTargetFs tsA tsB = Prelude.foldr addTargetFrequency tsB tsA

addTargetFrequency :: TargetFrequency -> [TargetFrequency] -> [TargetFrequency]
addTargetFrequency (target, frequency) table = case Prelude.lookup target table of
    Nothing -> (target, frequency) : table
    Just n -> (target, n+frequency) : Prelude.filter notT table where
        notT (r, _) = r /= target

getWords :: String -> IO [String]
getWords fileName = fmap words $ readFile fileName