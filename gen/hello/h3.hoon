::  Keyword argumented hello world example. Defaults if no sample given.
::  Run in :dojo with:
::
::    ~your-urbit:dojo/examples> +hello/h3, =txt 'Mars'
::    'Hello, Mars!'
::
::    ~your-urbit:dojo/examples> +hello/h3
::    'Hello, universe'

::  /hoon/h3/hello/gen
::
!:
::
:-  %say
|=  {^ {$~ txt/_'universe'}}
:-  %noun
(crip (weld (weld "Hello, " (trip txt)) "!"))
