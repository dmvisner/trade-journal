module Web.View.Positions.Index where
import Web.View.Prelude

data IndexView = IndexView { positions :: [Position]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <!-- {breadcrumb} -->

        <h1>Index<a href={pathTo NewPositionAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Position</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <!-- <tbody>{forEach positions renderPosition}</tbody> -->
            </table>
            
        </div>
    |]
--         where
--             breadcrumb = renderBreadcrumb
--                 [ breadcrumbLink "Positions" PositionsAction
--                 ]

-- renderPosition :: Position -> Html
-- renderPosition position = [hsx|
--     <tr>
--         <td>{position}</td>
--         <td><a href={ShowPositionAction position.id}>Show</a></td>
--         <td><a href={EditPositionAction position.id} class="text-muted">Edit</a></td>
--         <td><a href={DeletePositionAction position.id} class="js-delete text-muted">Delete</a></td>
--     </tr>
-- |]