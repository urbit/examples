::  Keyword argumented hello world example. Defaults if
::  no sample given.
:: 
::  Run in :dojo with:
::
::    ~your-urbit:dojo/examples> +hello/h3, =txt 'Mars'
::    'Hello, Mars!'
::
::    ~your-urbit:dojo/examples> +hello/h3
::    'Hello, universe'
::
::::  /===/gen/hello/h3/hoon
  ::
!:
::
:-  %say
|=  [^ [~ txt=_'universe']]
:-  %noun
(crip (weld (weld "Hello, " (trip txt)) "!"))
