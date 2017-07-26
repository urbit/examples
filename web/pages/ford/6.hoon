::    Ford example 6
::    accessible at http://localhost:8080/home/pub/ford6
::
::::  /hook/hymn/ford6/pub
  ::
|%
++  fib
  |=  x/@
    ?:  (lth x 2)
      1
    (add $(x (dec x)) $(x (sub x 2)))
--
::
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: Exercise 6
  ==
  ;body
    ;div
      ;h1: Exercise 6 — Loops
      ;p: {<(fib 1)>}, {<(fib 2)>}, {<(fib 3)>}, {<(fib 4)>}
    ==
  ==
==
