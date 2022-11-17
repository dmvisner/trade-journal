module Web.View.Plays.Edit where
import Web.View.Prelude

data EditView = EditView { play :: Play }

instance View EditView where
    html EditView { .. } = [hsx|
        {breadcrumb}
        <h1>Edit Play</h1>
        {renderForm play}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Plays" PlaysAction
                , breadcrumbText "Edit Play"
                ]

renderForm :: Play -> Html
renderForm play = formFor play [hsx|
    {(textField #strategy)}
    {(textField #direction)}
    {(textField #isLong)}
    {(textField #underlying)}
    {(textField #pctMaxGoal)}
    {(textField #closingThoughts)}
    {(textField #isSuccess)}
    {(textField #commission)}
    {(textField #fees)}
    {(textField #underlyingPrice)}
    {(textField #profitProb)}
    {(textField #openingThoughts)}
    {submitButton}

|]