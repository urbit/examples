::  Accepts an atom from the dojo and squares it.
::
::::  /===/app/square/hoon
  ::
!:
|%                                                      ::>  no moves in :square
+=  move  [bone card]                                   ::>  no cards in :square
+=  card  $%  ~
          ==
--
::
|_  [bow=bowl:gall ~]                                  ::<  stateless
::
++  poke-atom
  |=  tom=@
  ^-  [(list move) _+>.$]
  ~&  square+(mul tom tom)
  [~ +>.$]
::
++  coup
  |=  [wir=wire err=(unit tang)]
  ^-  [(list move) _+>.$]
  ?~  err
    ~&  square+success+'Poke succeeded!'
    [~ +>.$]
  ~&  square+error+'Poke failed. Error:'
  ~&  square+error+err
  [~ +>.$]
::
--
