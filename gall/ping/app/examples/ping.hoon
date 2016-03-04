/?    314
|%
  ++  move  ,[bone term wire *]
--
!:
|_  [bowl state=~]
::
++  poke-ping-message
  |=  [to=@p message=@t]
  ^-  [(list move) _+>.$]
  [[[ost %poke /sending [to dap] %atom message] ~] +>.$]
::
++  poke-atom
  |=  arg=@
  ^-  [(list move) _+>.$]
  ~&  [%receiving (,@t arg)]
  [~ +>.$]
::
++  coup  |=(* `+>)
--
