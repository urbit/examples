::    project euler 14
::    https://projecteuler.net/problem=14
::
::::  /hoon/euler14/try/
  ::
=<  (longcol 1.000.000) :: 1mil runs far too slowly uncached
::
::::  ~haptem-fopnys
  ::
|%
 
++  collatz :: given a, returns the number of steps needed to reach 1
  |=  [a=@u]
  ~+
  =+  [curr=a len=1]
  |-  ^-  @u
  ?:  =(curr 1)
    len
  ?:  =((mod curr 2) 0)
    $(curr (div curr 2), len +(len))
  $(curr (add (mul curr 3) 1), len +(len))

++  longcol :: find the longest collatz sequence under a
  |=  [a=@u]
  =+  [len=0 num=0 acc=1]
  |-  ^-  [@u @u]
    =+  col=(collatz acc)
  ?:  =(acc a)
    [num len]
  ?:  (lte len col)
    $(len col, num acc, acc +(acc))
  $(acc +(acc))
--
