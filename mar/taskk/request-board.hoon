::
::  /hoon/request-board/taskk/mar
/?    310
::
!:
|_  board/{ho/tape bo/tape}
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  {ho/tape bo/tape}
    %-  need
    %.  jon
    (ot host+sa board+sa ~):jo
  --
--
