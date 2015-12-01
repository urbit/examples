/?    314
|%
  ++  move  ,[bone term path *]
--
!:
|_  [bowl state=~]
::
++  poke-urbit
  |=  to=@p
  ^-  [(list move) _+>.$]
  [[[ost %poke /sending [to dap] %atom 'howdy'] ~] +>.$]
::
++  poke-atom
  |=  arg=@
  ^-  [(list move) _+>.$]
  ~&  [%receiving (,@t arg)]
  [~ +>.$]
::
++  coup  |=(* [~ +>.$])
--
