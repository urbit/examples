/?    314
|%
  ++  move  ,*
--
!:
|_  [bowl state=~]
::
++  poke-atom
  |=  arg=@
  ^-  [(list move) _+>.$]
  ~&  [%square (mul arg arg)]
  [~ +>.$]
--
