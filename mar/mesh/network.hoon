::  Your network of friends and friends-of-friends
::
::::  /===/mar/mesh/network/hoon
  ::
/-  mesh
[. mesh]
::
!:
|_  [col=color net=network]
++  grab  |%
          +=  noun  [color network]
          --
++  grow
  |%
  ++  json
    (pairs:enjs:format col+[%s col] net+network-json ~)
  ::
  ++  network-json
    ::>  push ++json:grow out of subject
    =>  +
    ^-  json
    %-  pairs:enjs:format  ^-  (list [@t json])
    %+  turn  ~(tap by net)
    |=  [key=ship fes=friends]  ^-  [@t json]
    [(scot %p key) (friends-to-json fes)]
  --
++  friends-to-json
  |=  fes=friends
  %-  pairs:enjs:format  ^-  (list [@t json])
  %+  turn  ~(tap in fes)
  |=  [frnd=friend col=color]
  [(scot %p frnd) [%s col]]
--

::
