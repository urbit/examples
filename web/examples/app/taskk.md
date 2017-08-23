# TASKK APP

*Manage issues on Urbit*

<img src="http://i.imgur.com/lvsnIlT.png" width="100%"/>

Taskk is a trello-esque app for managing distributed todo boards on Urbit. We
use clay as our shared state. This allows multiple users to sync issues, etc.
The basic unit of the app is the issue, which is stored as an md file. As much
as possible is encoded in the file path, so that app functions as a wrapper
around clay to enforce rules, etc.

Any large-scale edits can be done in vim or a similar editor by simply editing
the markdown file associated with an issue.

## Install

1.  Copy /app/taskk.hoon to `%/app/taskk.hoon` on your ship
2.  Run `|start %taskk`. *Note* This only needs to be done once.
3.  Install taskk-ui, which is included as a git submodule. Make sure that the
    submodule has been properly dl-ed by running
    `git submodule update --init --recursive`
4.  Follow [instructions](https://github.com/vvisigoth/taskk-ui) to install and
    run the front-end on your ship.

## Instructions

You can also interact with the taskk app from the `:dojo` by poking the app with
the appropriate marks. The following marks are available.

-   `:taskk %taskk-create-issue <phase>/tape <id>/tape <description>/tape`
-   `:taskk %taskk-delete-issue <phase>/tape <id>/tape`
-   `:taskk %taskk-change-phase <current-phase>/tape <desired-phase>/tape <id>/tape`
-   `:taskk %taskk-request-board <host>/tape <board>/tape`
