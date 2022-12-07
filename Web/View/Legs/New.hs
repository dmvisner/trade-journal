module Web.View.Legs.New where
import Web.View.Prelude
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import qualified Prelude as P

data NewView = NewView { strategy :: Strategy, legs :: [Leg] }

instance View NewView where
    html NewView { .. } = [hsx|
        <!-- {breadcrumb} -->
        <form id="legs-form" method="POST" action={CreateLegsAction}>

            <div class="row mb-3">
                { forEach legs renderForm }
            </div>
            <input type="submit" class="btn btn-primary mb-3"/>
        </form>
    |]
        -- where
        --     breadcrumb = renderBreadcrumb
        --         [ breadcrumbLink "Play" ShowPlayAction { playId }
        --         , breadcrumbText "Add Legs"
        --         ]



renderForm :: Leg -> Html
renderForm leg = [hsx|
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