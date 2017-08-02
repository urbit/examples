::  Project Euler 2
::  https://projecteuler.net/problem=2
::  run in dojo with +examples/project-euler/p002
::
::  p002/project-euler/gen
::
!:
::
:-  %say  |=  *
:-  %noun
=<  (fib 4.000.000)
::
|%
++  fib
  |=  lim/@
  =+  [fst=1 scd=2]
  |-
  ?.  (lte scd lim)
    ~
  ?:  =((mod scd 2) 0)
    (add scd $(fst scd, scd (add fst scd)))
  $(fst scd, scd (add fst scd))
--
