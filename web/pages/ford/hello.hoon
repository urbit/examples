//  /%%/hello/lib
|%
++  hello
  |=  *
  (weld "Hello, " (weld (trip (world %hello)) "!"))
--
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: Examples - Ford - Hello
    ;link(rel "stylesheet", type "text/css", href "/~~/pages/ford/ford.css");
  ==
  ;body
    ;h1#title: %ford: hello
    ;div
      ;h1: {(hello %world)}
    ==
  ==
==
