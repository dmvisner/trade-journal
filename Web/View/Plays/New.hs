module Web.View.Plays.New where
import Web.View.Prelude
import Application.Script.Prelude (respondHtml, redirectTo)


data NewView = NewView { play :: Play }

instance View NewView where
    html NewView { .. } = [hsx|
        <h1>Add Play</h1>
        {renderForm play}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Plays" PlaysAction
                , breadcrumbText "New Play"
                ]

renderForm :: Play -> Html
renderForm play = formFor play [hsx|
    {(selectField #direction getDirectionList) {autofocus = True}}
    {(selectField #strategy getStrategyList)}
    {(textField #underlying)}
    {(numberField #underlyingPrice)}
    {(numberField #commission)}
    {(numberField #fees)}
    {(numberField #profitProb)}
    {(textField #openingThoughts) {placeholder = "Why did you open this trade?"}}
    {submitButton}
|]

instance CanSelect Text where
    type SelectValue Text = Text
    selectValue text = text
    selectLabel text = text