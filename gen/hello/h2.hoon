::  Keyword argumented hello world example
::  Run in :dojo with:
::
::    ~your-urbit:dojo/examples> +hello/h2 'Mars'
::    'Hello, Mars!'
::
::::  /===/gen/hello/h2/hoon
  ::
!:
::
:-  %say
|=  [^ [[txt=@t ~] ~]]
:-  %noun
(crip (weld (weld "Hello, " (trip txt)) "!"))
