module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import qualified Prelude as P
import IHP.View.Form

data WebApplication = WebApplication deriving (Eq, Show)

data Strategy = 
    IronCondor
    | PutVertical
    | CallVertical
    | Strangle
    | Straddle
    | Put
    | Call
    | Calendar
    | Diagonal
    deriving (Enum, Bounded, Eq, Read, Show)

instance CanSelect Strategy where
    type SelectValue Strategy = Text
    selectValue = show

    selectLabel IronCondor = "Iron Condor"
    selectLabel PutVertical = "Put Vertical"
    selectLabel CallVertical = "Call Vertical"
    selectLabel strategy = show strategy

data Direction =
    Bullish
    | Bearish
    | Neutral
    deriving (Enum, Bounded, Eq, Show)

instance CanSelect Direction where
    type SelectValue Direction = Text
    selectValue = show
    
    selectLabel = show

data Position = Position Play [Leg] deriving (Show)

data PlaysController
    =  NewPlayAction
    | CreatePlayAction
    deriving (Eq, Show, Data)


data LegsController
    = NewLegsAction
    | CreateLegsAction
    deriving (Eq, Show, Data)

data PositionsController
    = PositionsAction
    | NewPositionAction
    | CreatePositionAction
    deriving (Eq, Show, Data)
