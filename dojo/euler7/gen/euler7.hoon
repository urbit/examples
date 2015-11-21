::    project euler 7
::    https://projecteuler.net/problem=7
::  run in dojo with +euler7 10.001
::
::::  /hoon/euler7/gen
  ::
:-  %say  |=  [^ [[a=@ ~] ~]]
:-  %noun
=<  (ith a)
::
::::  ~racbes-solmun
  ::
|%
++  iip
  |=  [n=@ primes=(list ,@)]
  =+  [c=0 lim=p:(sqt n)]
  |-  ^-  @f
  =+  p=(snag c primes)
  ?:  =(0 (mod n p))
    %.n
  ?:  (gth p lim)
    %.y
  $(c +(c))
::
++  ith
  |=  i=@
  =+  [n=3 primes=`(list ,@)`[2 ~]]
  |-  ^-  @u
  ?.  (iip n primes)
    $(n (add 2 n))
  ?:  =((lent primes) (dec i))
    n
  $(n (add 2 n), primes (weld primes (limo [n ~])))
--