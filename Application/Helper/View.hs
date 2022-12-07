module Application.Helper.View where

import IHP.ViewPrelude
import Data.Char(isUpper)

-- Here you can add functions which are available in all your views
strategyLabel :: String -> String
strategyLabel [] = []
strategyLabel (x:xs) | isUpper x = ' ' : x : strategyLabel xs
                     | otherwise = x : strategyLabel xs

