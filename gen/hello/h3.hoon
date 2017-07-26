::  Keyword argumented hello world example. Defaults if no sample given.
::  Run in dojo with:
::
::    +hello/h3, =txt %planets
::    +hello/h3, =txt %stars
::    +hello/h3, =txt %galaxies
::    +hello/h3

::  /hoon/h3/hello/gen
::
!:
::
:-  %say
|=  {^ {$~ txt/_`@t`%universe}}
:-  %noun
(crip (weld (weld "Hello, " (trip txt)) "!"))
