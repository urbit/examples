::
::  /hoon/create-issue/taskk/mar
/?    310
/-  taskk
!:
[taskk .]
|_  iss/issue
++  grab
  |%
  ++  json
    |=  jon/^json
    ^-  issue
    %-  need
    %.  jon
    (ot phase+sa issue+sa description+sa ~):jo
  --
++  grow
  |%
  ++  json
    %-  jobe 
      :~  [%phase (jape pha.iss)]
        [%issue (jape iss.iss)] 
        [%description (jape des.iss)]
      ==
  --
--
