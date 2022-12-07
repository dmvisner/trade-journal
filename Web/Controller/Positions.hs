module Web.Controller.Positions where

import Web.Controller.Prelude
import Web.View.Positions.Index
import Web.View.Positions.New

instance Controller PositionsController where
    action PositionsAction = do
        plays <- query @Play |> fetch
        legs <- query @Leg |> fetch
        let positions = map (\play -> Position play (filter (\leg -> leg.play == play.id) legs)) plays
        render IndexView { .. }

    action NewPositionAction = do
        let play = newRecord @Play
        render NewView { .. }

    action CreatePositionAction = do
        putStrLn "Done"

buildPosition position = position
    |> fill @'[]
