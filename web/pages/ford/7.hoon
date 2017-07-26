::  Ford example 7
::  accessible at http://localhost:8080/home/pub/ford7
::
::  /hook/hymn/ford7/pub
::
/=  gas  
/$  fuel
::
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: %ford Example 7
  ==
  ;body
    ;div
      ;h1: %ford Example 7 — Page Variables
      ;div.who: Whoami? {<(~(get ju aut.ced.gas) 0)>}
      ;div.where: Whereami? {(spud s.bem.gas)}
      ;div.what: Whatcase? {(scow %ud p.r.bem.gas)}
      ;div.code: Session auth credential:
        ;code
          ;pre: {<gas>}
        ==
    ==
  ==
==
