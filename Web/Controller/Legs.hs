module Web.Controller.Legs where

import Web.Controller.Prelude
import Web.View.Legs.New
import Data.Time.Clock
import Data.Time.Calendar
import qualified Web.View.Plays.New as NP
import Web.Controller.Plays as PC
import qualified Prelude as P
import qualified Data.Text as T
import qualified Data.Either as E
import qualified IHP.Log as Log

instance Controller LegsController where
    action NewLegsAction = do
        let play = newRecord @Play
        play
            |> buildPlay
            |> ifValid \case
                Left play -> do
                    render NP.NewView { .. } 
                Right play -> do
                    today <- utctDay <$> getCurrentTime
                    setSession "underlying" play.underlying
                    setSession "strategy" play.strategy
                    setSession "direction" play.direction
                    setSession "quanitity" play.quantity
                    let legs = replicate (numLegsForStrategy (P.read . T.unpack $ play.strategy)) (newRecord @Leg)
                    render NewView { strategy = P.read . T.unpack $ play.strategy, legs = legs }

    action CreateLegsAction = do
        let openPrices = paramList @Int "openPrice"
        let expDates = paramList @Day "expirationDate"
        today <- utctDay <$> getCurrentTime

        let legs = zip openPrices expDates
                |> map (\(open, date) -> newRecord @Leg
                        |> set #expirationDate date
                        |> set #openPrice open
                        -- |> set #play playId
                        |> validateField #expirationDate (isSameOrAfterDay today)
                        |> validateField #openPrice (isGreaterThan 0)
                    )

        validatedLegs :: [Either Leg Leg] <- forM legs (ifValid pure)

        case E.partitionEithers validatedLegs of
            ([], legs) -> do
                createMany legs
                setSuccessMessage "Legs created"
                --redirectTo PlaysAction
            (invalidLegs, validLegs) -> do
                -- play <- fetch playId
                let strategy = IronCondor
                render NewView { strategy = strategy, legs = legs }

buildLeg leg = leg
    |> fill @["openPrice", "play"]
