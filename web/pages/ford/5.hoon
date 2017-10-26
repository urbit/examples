::    Ford example 5
::    accessible at http://localhost:8443/~~/pages/ford/5
::
::::  /===/web/pages/ford/5/hoon
  ::
|%
  +=  dist  [start=@ud end=@ud]
  ++  length
    |=  [d=dist]
    (sub end.d start.d)
--
::
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: Examples - Ford 5
    ;link(rel "stylesheet", type "text/css", href "/~~/pages/ford/ford.css");
  ==
  ;body
    ;h1#title: %ford: 5
    ;div
      ;h1: Cores 2
      ;p: How long does it take to get from 2 to 20? {<(length 2 20)>}
    ==
  ==
==
