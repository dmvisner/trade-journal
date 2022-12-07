module Web.View.Plays.New where
import Web.View.Prelude


data NewView = NewView { play :: Play }

instance View NewView where
    html NewView { .. } = [hsx|
        <!-- {breadcrumb} -->
        {renderForm play}
    |]
        -- where
        --     breadcrumb = renderBreadcrumb
        --         [ breadcrumbLink "Plays" PlaysAction
        --         , breadcrumbText "New Play"
        --         ]

renderForm :: Play -> Html
renderForm play = formFor' play (pathTo NewLegsAction) [hsx|
    {(numberField #quantity)}
    {(textField #underlying) { additionalAttributes = [ ( "style", "text-transform: uppercase" ), ( "maxlength", "6" )]}}
    {(selectField  #direction getDirectionList)}
    {(selectField  #strategy getStrategyList)}
    {submitButton}

|]