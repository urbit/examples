::  Keyword argumented hello world example
::  Run in :dojo with:
::
::    ~your-urbit:dojo/examples> +hello/h2 'Mars'
::    'Hello, Mars!'
::
::  /hoon/h2/hello/gen
::
!:
::
:-  %say
|=  {^ {{txt/@t $~} $~}}
:-  %noun
(crip (weld (weld "Hello, " (trip txt)) "!"))
