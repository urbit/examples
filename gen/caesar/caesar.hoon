::  A Caesar cipher generator
::
::  Call from dojo with +caesar ["message" n]
::
::::
  ::
|=  [a=tape b=@]
|^  ^-  tape
  |-
  ?~  b  a
  $(a (turn a inc), b (dec b))
++  inc  
  |=  c=@t
  ^-  @t
  ?:  ?|  (lth c 'A') 
          (gth c 'z') 
          &((gth c 'Z') (lth c 'a'))
      ==
    c
  ?:  =(c 'z')
     'a' 
  ?:  =(c 'Z')
      'A'
    +(c)
--
