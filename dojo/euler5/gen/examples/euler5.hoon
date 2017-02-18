::  Project Euler 5
::  https://projecteuler.net/problem=5
::  run in dojo with +examples/euler5
::
::  /gen/examples/euler5
::
/?  310
::
!:
::
:-  %say  |=  *
:-  %noun
=<  (lcm 20)
::
!.
::
|%
++  sieve :: given a, check if a%div==0, incrementing div until it's lim, or .y
  |=  {a/@u lim/@u}
  =+  div=1
  |-  ^-  @f
  ?:  =(div lim)
    .y
  ?:  =((mod a div) 0)
    $(div +(div))
  .n
::
++  lcm :: check if sieve returns .y, incrementing the number until it does
  |=  a/@u
  =+  b=a
  |-  ^-  @u
  ?:  =((sieve b a) .y)
    b
  $(b (add b a))
--
