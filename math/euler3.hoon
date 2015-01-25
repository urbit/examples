::    project euler 3
::    https://projecteuler.net/problem=3
::
::::  /hoon/euler3/try/
  ::
=<  (lpf 600.851.475.143)
::
::::
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
