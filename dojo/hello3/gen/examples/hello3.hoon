::  Keyword argumented hello world example. Defaults if no sample given.
::  run in dojo with
::
::    +examples/hello3, =txt %earth
::    +examples/hello3, =txt %moon
::    +examples/hello3, =txt %stars
::    +examples/hello3
::
::::  /gen/examples/hello3
  ::
/?  310
::
::::
  !:
:-  %say
|=  {^ {$~ txt/_`@t`%mars}}
:-  %noun
(crip (weld "hello, " (trip txt)))
