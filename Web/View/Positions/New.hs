module Web.View.Positions.New where
import Web.View.Prelude
import IHP.ServerSideComponent.ViewFunctions
import Web.Component.LegsDisplay

data NewView = NewView { play :: Play }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Position</h1>
                <form id="position-form" method="POST" action={CreatePositionAction}>

            <div class="row mb-3">
                { renderForm play }
            </div>
            <input type="submit" class="btn btn-primary mb-3"/>
        </form>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Positions" PositionsAction
                , breadcrumbText "New Position"
                ]

renderForm :: Play -> Html
renderForm play = formFor play [hsx|
        {(numberField #quantity)}
        {(textField #underlying) { additionalAttributes = [ ( "style", "text-transform: uppercase" ), ( "maxlength", "6" )]}}
        {(selectField  #direction getDirectionList)}
        {(selectField  #strategy getStrategyList)}
        <!-- leg component goes here -->
        {legs}
    |]
    where
        legs = component @LegsDisplay

-- renderForm :: Leg -> Html
-- renderForm leg = [hsx|
--         <div class="col-auto">
--             <label class="form-label" for="leg_openPrice">
--                 Open Price
--             </label>
--             <input type="text" name="openPrice" id="leg_openPrice" value={show leg.openPrice} class={classes ["form-control", ("is-invalid", isInvalidPrice)]}/>
--             {priceFeedback}
--             <label class="form-label" for="leg_expDate">
--                 Expiration Date
--             </label>
--             <input type="date" name="expirationDate" id="leg_expDate" value={show leg.expirationDate} class={classes ["form-control", ("is-invalid", isInvalidDate)]}/>
--             {dateFeedback}
--         </div>
--     |]
--         where
--             isInvalidPrice = isJust (getValidationFailure #openPrice leg)
--             isInvalidDate = isJust (getValidationFailure #expirationDate leg)

--             priceFeedback = case getValidationFailure #openPrice leg of
--                 Just result -> [hsx|<div class="invalid-feedback">{result}</div>|]
--                 Nothing -> [hsx|<div></div>|]

--             dateFeedback = case getValidationFailure #expirationDate leg of
--                 Just result -> [hsx|<div class="invalid-feedback">{result}</div>|]
--                 Nothing -> [hsx|<div></div>|]