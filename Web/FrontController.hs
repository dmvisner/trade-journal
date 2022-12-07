module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)
import IHP.ServerSideComponent.RouterFunctions
import Web.Component.LegsDisplay

-- Controller Imports
import Web.Controller.Positions
import Web.Controller.Legs
import Web.Controller.Plays
import Web.Component.LegsDisplay (LegsDisplay)

instance FrontController WebApplication where
    controllers = 
        [ startPage PositionsAction
        -- Generator Marker
        , parseRoute @PositionsController
        , parseRoute @LegsController
        , parseRoute @PlaysController
        , routeComponent @LegsDisplay
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
