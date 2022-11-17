module Web.View.Plays.Index where
import Web.View.Prelude

data IndexView = IndexView { plays :: [Play]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <h1>Plays<a href={pathTo NewPlayAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach plays renderPlay}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Plays" PlaysAction
                ]

renderPlay :: Play -> Html
renderPlay play = [hsx|
    <tr>
        <td><a href={ShowPlayAction play.id}>{play.underlying} {play.strategy}</a></td>
        <td><a href={EditPlayAction play.id} class="text-muted">Edit</a></td>
        <td><a href={DeletePlayAction play.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]