::  arms accessible in dojo after `/+  sorts` (two spaces (`gap`) in between)
::  try `test:sorts`
::
::  /libs/sorts
::
/?    314
::
!:
::
|%
++  test  [(merge-sort [10 5 4 6 ~]) (bubble-sort [10 5 4 6 ~])]
::
++  sort
  |=  [liz=(list ,@ud)]
  ^+  liz
  ?~  liz  ~
  =+  ^-  state=[[leftside=(list ,@ud)] [bubble=@u] [rightside=(list ,@ud)]]
      [*(list ,@ud) i.liz t.liz]
  |-
  ?~  rightside.state
    [bubble.state ^$(liz leftside.state)]       ::  recurse with biggest bubbled out
  ?:  (gth bubble.state i.rightside.state)
    $(state [[i.rightside.state leftside.state] [bubble.state] [t.rightside.state]])  ::  have to prepend
  $(state [[bubble.state leftside.state] [i.rightside.state] [t.rightside.state]])    ::  the new bubble
::
++  bubble-sort
  |=  [a=(list ,@ud)]
  (flop (sort a))
::
++  merge-sort
  |=  [liz=(list ,@ud)]
  ?:  (lth (lent liz) 2)
    liz
  =+  mid=(div (lent liz) 2)
  (merge (merge-sort (scag mid liz)) (merge-sort (slag mid liz)))
::
++  merge
  |=  [left=(list ,@ud) right=(list ,@ud)]
  =+  merged=*(list ,@ud)
  |-
  ::need ?= for type system to let us retrieve head in lines 34, 35
  ?.  ?|(?=(~ left) ?=(~ right))
    ?:  (gth i.left i.right)
      $(merged [i.right merged], right t.right)
    $(merged [i.left merged], left t.left)
  ?^  left
    $(merged [i.left merged], left t.left)
  ?^  right
    $(merged [i.right merged], right t.right)
  (flop merged)  ::  both are empty; flop because hoon only allows prepending
--
