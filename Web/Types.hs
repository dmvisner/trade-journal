module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import qualified Prelude as P

data WebApplication = WebApplication deriving (Eq, Show)
data StaticController = WelcomeAction deriving (Eq, Show, Data)

data PlaysController
    = PlaysAction
    | NewPlayAction
    | ShowPlayAction { playId :: !(Id Play) }
    | CreatePlayAction
    | EditPlayAction { playId :: !(Id Play) }
    | UpdatePlayAction { playId :: !(Id Play) }
    | DeletePlayAction { playId :: !(Id Play) }
    deriving (Eq, Show, Data)

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
    deriving (Enum, Bounded, Eq)

data Direction = Bullish | Bearish | Neutral deriving (Enum, Bounded, Eq, Show)

instance P.Show Strategy where 
    show IronCondor = "Iron Condor"
    show PutVertical = "Put Vertical"
    show CallVertical = "Call Vertical"
    show Strangle = "Strangle"
    show Straddle = "Straddle"
    show Put = "Put"
    show Call = "Call"
    show Calendar = "Calendar"
    show Diagonal = "Diagonal" 