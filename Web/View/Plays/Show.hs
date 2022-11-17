module Web.View.Plays.Show where
import Web.View.Prelude

data ShowView = ShowView { play :: Play }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <h1>{play.underlying} {play.strategy}</h1>
        <p>{play}</p>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Plays" PlaysAction
                            , breadcrumbText "Show Play"
                            ]