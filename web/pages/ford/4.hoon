::    Ford example 4
::    accessible at http://localhost:8080/home/pub/ford4
::
::::  /hook/hymn/ford4/pub
  ::
|%
  ++  start  1
  ++  end  10
  ++  length
    |=
      {s/@ud e/@ud}
    (sub e s)
--
::
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: Exercise 4
  ==
  ;body
    ;div
      ;h1: Exercise 4 — Cores
      ;p: We'll be starting at {<start>}
      ;p: And ending at {<end>}
      ;p: Looks like a length of {<(length start end)>}
    ==
  ==
==
