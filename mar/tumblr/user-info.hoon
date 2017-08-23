::
::  /hoon/user-info/tumblr/mar
::
/?    310
/-  tumblr
/+  tumblr-parse
!:
|_  info/user-info:tumblr
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  user-info:tumblr
    %-  need
    (user-info-r:tumblr-parse jon)
  ++  noun  info
  --
--
