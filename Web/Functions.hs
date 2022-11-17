module Web.Functions where

import IHP.Prelude
import Web.Types

getStrategyList :: [Text]
getStrategyList = map show (enumFrom (minBound :: Strategy))

getDirectionList :: [Text]
getDirectionList = map show (enumFrom (minBound :: Direction))
