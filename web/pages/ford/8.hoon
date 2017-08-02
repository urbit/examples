::  Ford example 8
::  accessible at http://localhost:8080/home/pub/ford8
::
::  /hook/hymn/ford8/pub
::
/=  gas
/$  fuel
::
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: Examples - Ford 8
    ;link(rel "stylesheet", type "text/css", href "/~~/pages/ford/ford.css");
  ==
  ;body
    ;h1#title: %ford: 8
    ;div
      ;h1: Query String Parameters
      ;div: Do you have a code?
      ;div: ?code={<(fall (~(get by qix.gas) %code) '')>}
    ==
  ==
==
