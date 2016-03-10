::  Keyword argumented hello world example
::  run in dojo with
::    +hel3o
::    +hel3o, =txt %earth
::    +hel3o, =txt %stars
::
::::  /hoon/hel3o/gen
  ::
/?  314
::
::::
  !:
:-  %say
|=  {^ {$~ txt=_`@t`%mars}}
:-  %noun
(crip (weld "hello, " (trip txt)))
