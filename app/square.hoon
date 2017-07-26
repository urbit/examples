::  Accepts an atom from the dojo and squares it.
::
::  /hoon/square/app
::
!:
|%                                                      ::>  no moves in :square
++  move  {bone card}                                   ::>  no cards in :square
++  card  $%  $~
          ==
--
::
|_  {bow/bowl $~}                                       ::<  stateless
::
++  poke-atom
  |=  tom/@
  ^-  (quip move +>.$)
  ~&  square+(mul tom tom)
  [~ +>.$]
::
++  coup
  |=  {wir/wire err/(unit tang)}
  ^-  (quip move +>.$)
  ?~  err
    ~&  success+'Poke succeeded!'
    [~ +>.$]
  ~&  error+'Poke failed. Error:'
  ~&  error+err
  [~ +>.$]
::
--
