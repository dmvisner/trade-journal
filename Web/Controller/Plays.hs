module Web.Controller.Plays where

import Web.Controller.Prelude
import Web.View.Plays.Index
import Web.View.Plays.New
import Web.View.Plays.Edit
import Web.View.Plays.Show

instance Controller PlaysController where
    action PlaysAction = do
        plays <- query @Play |> fetch
        render IndexView { .. }

    action NewPlayAction = do
        let play = newRecord
        render NewView { .. }

    action ShowPlayAction { playId } = do
        play <- fetch playId
        render ShowView { .. }

    action EditPlayAction { playId } = do
        play <- fetch playId
        render EditView { .. }

    action UpdatePlayAction { playId } = do
        play <- fetch playId
        play
            |> buildPlay
            |> ifValid \case
                Left play -> render EditView { .. }
                Right play -> do
                    play <- play |> updateRecord
                    setSuccessMessage "Play updated"
                    redirectTo EditPlayAction { .. }

    action CreatePlayAction = do
        let play = newRecord @Play
        play
            |> buildPlay
            |> ifValid \case
                Left play -> render NewView { .. } 
                Right play -> do
                    play <- play |> createRecord
                    setSuccessMessage "Play created"
                    redirectTo PlaysAction

    action DeletePlayAction { playId } = do
        play <- fetch playId
        deleteRecord play
        setSuccessMessage "Play deleted"
        redirectTo PlaysAction

buildPlay play = play
    |> fill @["strategy", "direction", "isLong", "underlying", "pctMaxGoal", "closingThoughts", "isSuccess", "commission", "fees", "underlyingPrice", "profitProb", "openingThoughts"]
    |> validateField #direction (isInList getDirectionList)
    |> validateField #strategy (isInList getStrategyList)
    |> validateField #underlying nonEmpty