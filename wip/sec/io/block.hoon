::  Test url +https://api.github.com/user
::
::::  /hoon/github/com/sec
  ::
/-  blockio
/+    basic-auth
[. blockio]
!:
|_  {bal/(bale @) $~}
++  filter-request
  |=  req/hiss
  ^-  sec-move
  =+  keys=(secrets (cue key.bal))
  =.  r.p.req
    ::  find pin & api_key and replace value
    %+  turn  r.p.req
    |=  {k/@t v/@t}
    ?:  =(k 'pin')  [k q.keys]
    ?.  =(k 'api_key')  [k v]
    [k (~(got by p.keys) v)]
  [%send req]
--
