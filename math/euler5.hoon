::    project euler 5
::    https://projecteuler.net/problem=5
::
::::  /hoon/euler5/try/
  ::
=<  (lcm 20)
::
::::  ~haptem-fopnys
  ::
|%
++  evdiv :: .y if a%b==0, else .n
  |=  [a=@u b=@u]
  ^-  @f
  ?:  =((mod a b) 0)
    .y
  .n 

++  sieve :: given a, check if a%b==0, incrementing b until it's lim or .y
  |=  [a=@u lim=@u]
  =+  b=1
  |-  ^-  @f
  ?:  =(b lim)
    .y
  ?:  =((evdiv a b) .y)
    $(b +(b))
  .n

++  lcm :: check if sieve returns .y, incrementing a number until it does
  |=  a=@u
  =+  b=1
  |-  ^-  @u
  ?:  =((sieve b a) .y)
    b
  $(b +(b))
--
