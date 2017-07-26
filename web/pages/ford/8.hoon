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
    ;title: %ford Example 8
  ==
  ;body
    ;div
      ;h1: %ford Example 8 — Query String Parameters
      ;div: Do you have a code?
      ;div: ?code={<(fall (~(get by qix.gas) %code) '')>}
    ==
  ==
==
