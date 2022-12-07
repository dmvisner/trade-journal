module Web.Controller.Plays where

import Web.Controller.Prelude
import Web.View.Plays.New
import qualified IHP.Log as Log
import qualified Prelude as P
import qualified Data.Text as T

instance Controller PlaysController where
    action NewPlayAction = do
        let play = set #quantity 1 newRecord
        render NewView { .. }

    action CreatePlayAction = do
        let play = newRecord @Play
        play
            |> buildPlay
            |> ifValid \case
                Left play -> do
                    render NewView { .. } 
                Right play -> do
                    play <- play |> createRecord
                    setSuccessMessage "Play created"
                    --redirectTo PlaysAction


buildPlay play = play
    |> fill @["quantity", "underlying", "direction", "strategy"]
    |> validateField #quantity (isGreaterThan 0)
    |> validateField #underlying nonEmpty
    |> validateField #direction nonEmpty
    |> validateField #strategy nonEmpty
