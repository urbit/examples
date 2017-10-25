::  The node color stored in :mesh's app state
::
::::  /===/mar/mesh/color/hoon
  ::
/-  mesh
[. mesh]
::
!:
|_  color
++  grab  |%
          +=  noun  color
          ++  json
            |=  jon=^json  ^-  color
            (need (so:dejs-soft:format jon))
          --
--
