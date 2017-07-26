::  Keyword argumented hello world example
::  Run in dojo with:
::
::   +hello/h2 %mars
::
::  /hoon/h2/hello/gen
::
!:
::
:-  %say
|=  {^ {{txt/@tas $~} $~}}
:-  %noun
(crip (weld (weld "Hello, " (trip txt)) "!"))
