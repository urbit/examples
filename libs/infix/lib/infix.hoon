::  Novel syntax usage: mathematics
::  arms accessible in dojo after `/+  infix` (two spaces (`gap`) in between)
::  try `test:infix`
::
::  /libs/infix
::
/?    314
::
!:
::
|%
++  test  (iffy [[a / 3] + [a / 2] - 4]:[(wrap a=10 sub) add])
::
++  arit  $|(_/ $+([@ @] @))          ::  arithmetic gate, / representing div
++  expr  $|(@ [l=expr n=arit r=expr])                  :: arithmetic expression
++  cale  |=(a=arit `$+([@ @] @)`?~(a div a))           :: resolve an arit
::  .=  7  (iffy 4 add 6 div 2)
++  iffy                              ::  compute infix expression
  |=  a=expr  ^-  @
  ?@  a  a
  ((cale n.a) $(a l.a) $(a r.a))
::
::  .=  5  (iffy 4 add 6 div 2)
++  riffy                             ::  compte infix, associating left
  |=  a=expr  ^-  @
  ?@  a  a
  ?@  r.a  ((cale n.a) $(a l.a) r.a)
  =.  l.r.a
    ((cale n.a) $(a l.a) $(a l.r.a))
  $(a r.a)
::
::  Usage: (wrap . gate)
::  Produces gate equivalent to a, that has . as most of its context
++  wrap                              ::  context rewrapping for fun and profit
  |*  [v=* a=_,*]
  =>  [func=a v]
  |=(args=_+<.func (func args))
--
