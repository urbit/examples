::  Project Euler 14
::  https://projecteuler.net/problem=14
::  run in dojo with +examples/project-euler/p014
::
::  p014/project-euler/gen
::
!:
::
:-  %say  |=  *
:-  %noun
=<  (longcol 1.000.000) :: With a manual cache, many times faster
::
!.
::
|%
++  collatz :: given a, returns the number of steps needed to reach 1
  |=  {a/@u cache/(map @u @u)}
  =+  [curr=a len=1]
  |-  ^-  @u
  ?:  =(curr 1)
    len
  ?:  (~(has by cache) curr) :: if the len is cached...
    (add (dec len) (~(got by cache) curr)) :: return the len + cached len
  ?:  =((mod curr 2) 0)
    $(curr (div curr 2), len +(len))
  $(curr (add (mul curr 3) 1), len +(len))
::
++  longcol :: find the longest collatz sequence under a
  |=  {a/@u}
  =+  [len=0 num=0 acc=1 cache=(molt `(list (pair @ @))`[[2 1] [4 2] ~])]
  |-  ^-  {@u @u}
    =+  col=(collatz acc cache)
  ?:  =(acc a)
    [num len]
  ?:  (lte len col)
    $(len col, num acc, acc +(acc), cache (~(put by cache) acc col))
  $(acc +(acc), cache (~(put by cache) acc col))
--
