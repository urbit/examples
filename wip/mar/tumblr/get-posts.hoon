::
::  /hoon/get-posts/tumblr/mar
::
::
/?    310
!:
|_  req/{identifier/@t id-start/@u}
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  {identifier/@t id-start/@u}
    %-  need
    ((ot 'identifier'^so 'id-start'^ni ~):jo jon)
  ++  noun  {identifier/@t id-start/@u}
  --
--
