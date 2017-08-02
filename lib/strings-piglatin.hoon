::  simple string manipulation
::  arms accessible in dojo after `/+  strings-piglatin`  (two spaces (`gap`) in between)
::  try `test:strings-piglatin`
::    ++pigl turns a single string to piglatin
::    ++plur pluralizes a word
::
::  /libs/strings-piglatin
::
/?    314
::
!:
::
|%                                                      ::  core
++  test  (pigl (plur "what"))                          ::  test:strin
++  pigl                                                ::  pig latin ++arm
|=  wrd/(list @t)                                      ::  gate, str sample
  ^-  tape                                              ::  check rslt is tape
  ?~  wrd                                               ::  if null
    ~&('please enter an input' ~)                       ::  then
  =+  :~  vwl=['a' 'e' 'i' 'o' 'u' ~]  end="ay"         ::  else tuple of vars
    fst=i.wrd                                           ::  head of list wrd
  snd=t.wrd                                             ::  tail
  ==                                                    ::  close tuple
  ?:  ?|(=(fst 'a') =(fst 'e') =(fst 'i') =(fst 'o') =(fst 'u'))
    (weld wrd end)
  (welp snd [fst end])

++  plur                                                ::  pluralize
|=  wrd/tape                                            ::  gate, tape sample
  =+  idx=(dec (lent wrd))
  =+  lst=`char`(snag idx wrd)
  =+  slast=(dec idx)
  ?-  lst                                               ::  switch (on tile)
    $s  ?:  =((snag slast wrd) 'u')
      (welp (scag slast wrd) "i")
    (welp wrd "es")
    $e  (welp wrd "s")
    $x  (welp wrd "es")
    $y  (welp (scag idx wrd) "ies")
    @   (welp wrd "s")
  ==
--
