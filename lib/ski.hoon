::  SKI calculus to nock compiler
::  arms accessible in dojo after `/+  ski` (two spaces (`gap`) in between)
::  try `test:ski`
::
::  /libs/ski
::
!:
::
=<  apex
|%
++  apex  |=(a/tape (compile (scan a ski-rule)))
++  skis  (list ?($s $k $i skis))
++  whit  (star ;~(pose ace (just '\0a')))
++  ski-rule
  %+  knee  *skis  |.  ~+
  %+  ifix  [whit whit]
  %+  more  whit
  ;~  pose
    (cold %s (mask "sS"))
    (cold %k (mask "kK"))
    (cold %i (mask "iI"))
    (ifix pel^per ski-rule)
  ::
  ::  %+  cook  |=(a/skis k+[a]~)
  ::  (ifix sel^ser ski-rule)
  ==
::
++  compile
  |=  a/skis  ^-  nock
  =.  a  (flop a)
  ?~  a  $(a [%i]~)
  |-  ^-  nock
  =/  tal
    ?-  i.a
      $s  [[%1 [%1 2]] [%1 [%0 1]] [[%1 1] [%0 1]]]
      $k  [[%1 1] [%0 1]]
      $i  [%0 1]
      *  ^$(a i.a)
    ==
  ?~  t.a  tal
  [%2 [%0 1] %2 [%1 tal] [%1 $(a t.a)]]
--
|%
++  test  .*([1 42] .*(7 (ski "S (K(SI)) K")))  :: (\x.\y. yx) 7 (\x.42)
--
:: i  [0 1]
:: k  [[1 1] [0 1]]
:: s  [[1 1 2] [1 0 1] [[1 1] [0 1]]]
:: :  [2 [0 1] 2 [1 +] [1 -]] :: .*(. .*(%r %l))


:: so (sxy) becomes \z.(((s x) y) z) becomes .*(z .*(y .*(x s)))
:: i.e. [2 [0 1] 2 [1 y] [1 2 [1 x] [1 s]]]

:: [2 `1 2
::   |+[2 `1 2 [2 `1 2 |+i |+[2 |+i |+S]]]
::   |+[2 `1 2 [2 `1 2 |+i |+[2 |+i |+S]]]
:: ]
:: (((S I) I) ((S I) I))
:: SII(SII)

:: \x. [\y [2 y X]]
::   [\y [2 y X]]
::   [[1 2] [0 1] [1 X]]

:: [[1 1 2] [1 0 1] [[1 1] [0 1]]]
:: [\x [\y [2 y x]]]

:: \
:: .*(.*(z y) .*(z x))
:: ((x z) (y z))

:: ((f x) y)

:: .*(y .*(x f))

:: \xy. foo
:: [[1 2] [[1 0 1] [1 1] [0 1]] 1 1 ...]
:: -> [2 [[0 1] [1 x]] 1 ...]
:: -> .*([y x] ...)
