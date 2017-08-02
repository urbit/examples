/-  mesh
[. mesh]
::
!:
|_  {col/color net/network}
++  grab  |%
          ++  noun  {color network}
          --
++  grow
  |%
  ++  json
    (jobe col+[%s col] net+network-json ~)
  ::
  ++  network-json
    ::>  push ++json:grow out of subject
    =>  +
    ^-  json
    %-  jobe  ^-  (list {@t json})
    %+  turn  (~(tap by net))
    |=  {key/ship fes/friends}  ^-  {@t json}
    [(scot %p key) (friends-to-json fes)]
  --
++  friends-to-json
  |=  fes/friends
  %-  jobe  ^-  (list {@t json})
  %+  turn  (~(tap in fes))
  |=  {frnd/friend col/color}
  [(scot %p frnd) [%s col]]
--

::
