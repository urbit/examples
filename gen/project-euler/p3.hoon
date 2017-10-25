::  Project Euler 3
::  https://projecteuler.net/problem=3
::
::  run in dojo with:
::    ~your-urbit:dojo/examples> +project-euler/p3
::
::::  /===/gen/project-euler/p3/hoon
  ::
!:
::
:-  %say  |=  *
:-  %noun
=<  (lpf 600.851.475.143)
::
|%
++  lpf
  |=  a=@
  =+  b=2
  |-  ^-  @
  ?:  (lth a (mul b 2))
    a
  ?:  =((mod a b) 0)
    $(a (div a b))
  $(b +(b))
--
