module Web.Component.LegsDisplay where

import IHP.ViewPrelude
import IHP.ServerSideComponent.Types
import IHP.ServerSideComponent.ControllerFunctions
import Generated.Types
import Web.Types
import Web.Controller.Prelude
import qualified Text.Read as TR
import qualified Data.Text as DT
import qualified IHP.Log as Log


data LegsDisplay = LegsDisplay 
    {   displayStrategy :: Strategy
    ,   legs :: [Leg] 
    }

data LegsDisplayController
    = ChangeStrategyAction { newStrategyText :: Text }
    deriving (Eq, Show, Data)

$(deriveSSC ''LegsDisplayController)

instance Component LegsDisplay LegsDisplayController where
    initialState = LegsDisplay { displayStrategy = IronCondor, legs = replicate 4 $ newRecord @Leg }

    render LegsDisplay { displayStrategy, legs } = [hsx|
        <div class="form-group mb-3">
            <label>
                Strategy
            </label>
            <select name="strategy" class="form-control" value={ inputValue $ show displayStrategy } onchange="callServerAction('ChangeStrategyAction', { newStrategyText: this.value})">
                { forEach getStrategyList makeStrategyOption } 
            </select>
        </div>
        <div class="row mb-3">
            { forEach legs makeLegColumn }
        </div>
    |]
        where 
            makeStrategyOption :: Strategy -> Html
            makeStrategyOption s = [hsx|<option value={show s}>{s}</option>|]

            makeLegColumn :: Leg -> Html
            makeLegColumn leg = [hsx|
                    <div class="col-auto">
                        <label class="form-label" for="leg_openPrice">
                            Open Price
                        </label>
                        <input type="text" name="openPrice" id="leg_openPrice" value={show leg.openPrice} class={classes ["form-control", ("is-invalid", isInvalidPrice)]}/>
                        {priceFeedback}
                        <label class="form-label" for="leg_expDate">
                            Expiration Date
                        </label>
                        <input type="date" name="expirationDate" id="leg_expDate" value={show leg.expirationDate} class={classes ["form-control", ("is-invalid", isInvalidDate)]}/>
                        {dateFeedback}
                    </div>
                |]
                    where
                        isInvalidPrice = isJust (getValidationFailure #openPrice leg)
                        isInvalidDate = isJust (getValidationFailure #expirationDate leg)

                        priceFeedback = case getValidationFailure #openPrice leg of
                            Just result -> [hsx|<div class="invalid-feedback">{result}</div>|]
                            Nothing -> [hsx|<div></div>|]

                        dateFeedback = case getValidationFailure #expirationDate leg of
                            Just result -> [hsx|<div class="invalid-feedback">{result}</div>|]
                            Nothing -> [hsx|<div></div>|]

    action state ChangeStrategyAction { newStrategyText } = do
        Log.debug $ show newStrategyText
        case TR.readMaybe (DT.unpack newStrategyText) :: Maybe Strategy of
             Just s ->  pure LegsDisplay { displayStrategy = s, legs = replicate (numLegsForStrategy s) (newRecord @Leg) }
             Nothing -> pure state
        
