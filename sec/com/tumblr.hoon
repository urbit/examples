::
::::  /hoon/tumblr/com/sec
  ::
/+    oauth1
!:
::::
  ::
|_  {bal/(bale keys:oauth1) to/token:oauth1}
::  ++aut is a "standard oauth1" core, which implements the
::  most common handling of oauth1 semantics. see lib/oauth1 for more details,
::  and examples at the bottom of the file.
++  aut  (~(standard oauth1 bal to) . |=(to/token:oauth1 +>(to to)))
::  Tumblr API wants a content length header
++  add-cl-header
  |=  a/sec-move  ^+  a
  ?.  ?=({$send *} a)  a
  :-  %send  :-  p.p.a  
  :+  p.q.p.a
    (~(add ja q.q.p.a) %content-length (scot %u ?~(r.q.p.a 0 p.u.r.q.p.a)))
  r.q.p.a
::
++  add-screen-name
  |=  a/httr  ^-  httr
  :+  p.a
    q.a
  (some (tact (weld (trip q:(need r.a)) "&screen_name=urbit")))
::
++  filter-request
  %+  out-add-header:aut
    token-request='https://www.tumblr.com/oauth/request_token'
  oauth-dialog='https://www.tumblr.com/oauth/authorize'
::
++  filter-response  res-handle-request-token:aut
::  NOTE: calling in-exchange-token:aut produces another gate
++  receive-auth-query-string
  %+  cork
    %-  in-exchange-token:aut
      exchange-url='https://www.tumblr.com/oauth/access_token'
  add-cl-header
::
++  receive-auth-response  
    (cork add-screen-name bak-save-token:aut)
++  discard-state  ~
--
