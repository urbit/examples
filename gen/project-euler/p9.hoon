::  Project Euler 9
::  https://projecteuler.net/problem=9
::
::  > A Pythagorean triplet is a set of three natural numbers, a < b < c, for
::  > which,
::  > >             a2 + b2 = c2
::  > For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.
::  > There exists exactly one Pythagorean triplet for which a + b + c = 1000.
::  > Find the product abc.
::
!:
::
:-  %say  |=  *
:-  %noun
=<  (find-pythagorean-triplet-abc-sum-eq-one-thousand [1 1 998])
::
|%
++  find-pythagorean-triplet-abc-sum-eq-one-thousand
  |=  {a/@u b/@u c/@u}                                  :: gate takes 3-num cell
  |-  ^-  @u                                            :: loop, prod is 1 num.
  ?:  ?!  =((add (add a b) c) 1.000)                    :: if a+b+c not= 1000,
    a                                                   :: produce a.
  %=  $                                                 :: else, call loop:
    a  |-  ^-  @u                                       :: a -> inner loop prod:
       ?:  =((add (mul a a) (mul b b)) (mul c c))       :: if abc are pyth. trip
         ~&  [a b c]                                    :: println cell [a b c].
         (mul (mul a b) c)                              :: & produce abc.
       ?:  (lth c b)                                    :: else, if no combos =,
         +(a)                                           :: increment a (reloop).
       $(b +(b), c (dec c))                             :: else, loop w b+1 c-1.
    c  (dec c)                                          :: c -> decrement c, c=1
  ==
--

:: > +examples/euler9
:: [200 375 425]
:: 31.875.000
