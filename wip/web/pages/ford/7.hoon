::  Ford example 7
::  accessible at http://localhost:8443/~~/pages/ford/7
::
:::: /===/web/pages/ford/7/hoon
  ::
/=  gas
/$  fuel:html
::
^-  manx
;html
  ;head
    ;meta(charset "utf-8");
    ;title: Examples - Ford 7
    ;link(rel "stylesheet", type "text/css", href "/~~/pages/ford/ford.css");
  ==
  ;body
    ;h1#title: %ford: 7
    ;div
      ;h1: Page Variables
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
