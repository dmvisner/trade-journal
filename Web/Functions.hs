module Web.Functions where

import IHP.Prelude
import Web.Types

getStrategyList :: [Strategy]
getStrategyList = enumFrom (minBound :: Strategy)

getDirectionList :: [Direction]
getDirectionList = enumFrom (minBound :: Direction)

numLegsForStrategy :: Strategy -> Int
numLegsForStrategy IronCondor = 4
numLegsForStrategy Call = 1
numLegsForStrategy Put = 1
numLegsForStrategy _ = 2