/?    314
!:
|_  [bowl state=@]
++  poke-atom
  |=  arg=@
  ^-  [(list) _+>.$]
  ~&  [%so-far (add state arg)]
  [~ +>.$(state (add state arg))]
--
