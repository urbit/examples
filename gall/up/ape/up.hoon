/?    314
|%
++  move  ,[bone card]
++  card
  $%  [%them wire (unit hiss)]
      [%wait wire @da]
  ==
--
|_  [hid=bowl on=_| in-progress=_| target=@t]
++  poke-cord
  |=  url=@t
  ^-  [(list move) _+>.$]
  ?:  =('off' url)
    [~ +>.$(on |)]
  ?:  =('on' url)
    :_  +>.$(on &, in-progress &)
    ?:  |(on in-progress)
      ~
    [ost.hid %them /request ~ (need (epur target)) %get ~ ~]~
  [~ +>.$(target url)]
++  thou-request
  |=  [wir=wire code=@ud headers=mess body=(unit octs)]
  ^-  [(list move) _+>.$]
  ?:  &((gte code 200) (lth code 300))
    ~&  [%all-is-well code]
    :_  +>.$
    [ost.hid %wait /timer (add ~s10 now.hid)]~
  ~&  [%we-have-a-problem code]
  ~&  [%headers headers]
  ~&  [%body body]
  :_  +>.$
  [ost.hid %wait /timer (add ~s10 now.hid)]~
++  wake-timer
  |=  [wir=wire ~]
  ?:  on
    :_  +>.$
    [ost.hid %them /request ~ (need (epur target)) %get ~ ~]~
  [~ +>.$(in-progress |)]
--
