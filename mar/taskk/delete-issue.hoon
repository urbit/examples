::
::  /hoon/delete-issue/taskk/mar
/?    310
/-  taskk
!:
[taskk .]
|_  iss/issue-ref
++  grab
  |%
  ++  json
  |=  jon/^json
  ^-  issue
  %-  need
  %.  jon
  (ot phase+sa issue+sa ~):jo
--
++  grow
  |%
  ++  json
  %-  jobe 
  :~  [%phase (jape pha.iss)]
      [%issue (jape iss.iss)] 
  ==
--
--
