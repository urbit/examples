::
::  /hoon/change-phase/taskk/mar
/?    310
/-  taskk
!:
[taskk .]
|_  iss/change-ref
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  issue
    %-  need
    %.  jon
    (ot issue+sa from-phase+sa to-phase host+sa board+sa ~):jo
  --
++  grow
  |%
  ++  json
    %-  jobe 
      :~  [%issue (jape iss.iss)] 
        [%from-phase (jape fpha.iss)]
        [%to-phase (jape tpha.iss)]
        [%hose (jape hos.iss)]
        [%board (jape boa.iss)]
      ==
  --
--
