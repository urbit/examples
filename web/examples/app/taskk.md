# `:taskk`

Source:

-   `/app/taskk.hoon`
-   `/gen/taskk/yaml.hoon`
-   `/mar/taskk/change-phase.hoon`
-   `/mar/taskk/create-issue.hoon`
-   `/mar/taskk/delete-issue.hoon`
-   `/mar/taskk/issue.hoon`
-   `/mar/taskk/request-board.hoon`
-   `/sur/taskk.hoon`
-   `/web/pages/taskk.html`
-   `/web/pages/mail.css`
-   `/web/pages/mail.js`

`:dojo`:

    ~your-urbit:dojo/examples> |start %taskk

Web:

    http://localhost:8443/~~/pages/taskk.html

Usage:
1. Each column has its own "create new" button.
2. Issues are extremely simple, having a title, an assignee, a description
3. Double click tile to expand.
4. Drag a tile to change phase.
5. These boards are stored as a directory of markdown files on your ship, 
at `%/app/taskk/HOST/BOARD/PHASE/ISSUE`. If you'd like to sync boards or 
collaborate, see the instructions in the docs on syncing desks.

`:dojo` (poke directly):

    ~your-urbit:dojo/examples> :taskk %taskk-create-issue <phase>/tape <id>/tape <description>/tape
    ~your-urbit:dojo/examples> :taskk %taskk-delete-issue <phase>/tape <id>/tape
    ~your-urbit:dojo/examples> :taskk %taskk-change-phase <current-phase>/tape <desired-phase>/tape <id>/tape
    ~your-urbit:dojo/examples> :taskk %taskk-request-board <host>/tape <board>/tape

*Manage issues on Urbit*

<img src="http://i.imgur.com/lvsnIlT.png" width="100%"/>

Taskk is a trello-esque app for managing distributed todo boards on Urbit. We
use clay as our shared state. This allows multiple users to sync issues, etc.
The basic unit of the app is the issue, which is stored as an md file. As much
as possible is encoded in the file path, so that app functions as a wrapper
around clay to enforce rules, etc.

Any large-scale edits can be done in vim or a similar editor by simply editing
the markdown file associated with an issue.

