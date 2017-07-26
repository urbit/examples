::  Ford example 9
::  accessible at http://localhost:8080/home/pub/ford9
::
::  /hook/hymn/ford9/pub
::
/=  gas
/$  fuel
::
|%
++  fib
  |=  x/@
    ?:  (lth x 2)
      1
    (add $(x (dec x)) $(x (sub x 2)))
++  arg
  %+  fall
    %+  biff
      (~(get by qix.gas) %number)
    (slat %ud)
  0
--
::
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: %ford Example 9
  ==
  ;body
    ;div
      ;h1: %ford Example 9 — Computing With Parameters
      ;div: {<(fib arg)>}
    ==
  ==
==
