::  Brainfuck in Hoon. Esoception.
::  Run in :dojo with:
::
::    +fun/bf 42
::
::  /hoon/bf/fun/gen
::
!:
::
:-  %say
|=  $:  ^
        {in/@ $~}
        $~
    ==
:-  %noun
=<  (bf ">++++++++[<+++++++++>-]<.>>+>+>++>[-]+<[>[->+<<++++>]<<]>.+++++++..+++.>>+++++++.<<<[[-]<[-]>]<+++++++++++++++.>>.+++.------.--------.>>+.>++++.") :: run vm
::
|%
++  bf
  |=  input/(list @)
  =+  [ip=0 current=0 left=(reap 0 0) right=(reap 30 0)]
  |-  ^-  (list @)
  ?:  =(ip (lent input))
    (welp left [current [right]])
  ?+  `@`(snag ip input)
    $(ip +(ip))
    $'+'  $(ip +(ip), current +(current))
    $'-'  $(ip +(ip), current (dec current))
    $'>'  %=  $
      ip  +(ip)
      left  (welp left ~[current])
      current  (snag 0 right)
      right  (slag 1 right)
      ==
    $'<'  %=  $
      ip  +(ip)
      left  (scag (dec (lent left)) left)
      current  (snag (dec (lent left)) left)
      right  (welp ~[current] right)
      ==
    $'['  ?.  =(current 0)
        $(ip +(ip))
      =+  [nest=0 pos=+(ip)]
      |-
        =+  char=`@`(snag pos input)
      ?:  =(char '[')
        $(nest +(nest), pos +(pos))
      ?:  =(char ']')
        ?:  =(nest 0)
          ^$(ip +(pos))
        $(nest (dec nest), pos +(pos))
      $(pos +(pos))
    $']'  ?:  =(current 0)
        $(ip +(ip))
      =+  [nest=0 pos=(dec ip)]
      |-
        =+  char=`@`(snag pos input)
      ?:  =(char ']')
        $(nest +(nest), pos (dec pos))
      ?:  =(char '[')
        ?:  =(nest 0)
          ^$(ip +(pos))
        $(nest (dec nest), pos (dec pos))
      $(pos (dec pos))
    $'.'  ~&  `@t`current
      $(ip +(ip))
    $','  %=  $
      ip  +(ip)
      current  (cut 3 [0 1] in)
      in  (rsh 3 1 in)
      ==
  ==
--
