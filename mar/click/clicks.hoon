::  Total number of clicks
::
::::  /===/mar/click/clicks/hoon
  ::
/-  click
[. click]
!:
|_  cis=clicks
++  grow
  |%
  ++  json
    (frond:enjs:format %clicks (numb:enjs:format cis))
  --
--
