::  Project Euler 2
::  https://projecteuler.net/problem=2
::  run in dojo with +examples/euler2
::
::  /gen/examples/euler2
::
:-  %say  |=  *
:-  %noun
=<  (fib 4.000.000)
::
::::  ~sivtyv-barnel
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
