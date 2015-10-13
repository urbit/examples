::    write with stat
::    +write allows you to enter text line by line.
::    on exit, lines are output as a wain
::      *%/save/txt +write
::      +cat %/save/txt
::    will record and print the contents in the filesystem
::
::::  /hoon/write/gen
  ::
/?    314
/-    sole
[sole .]
::
!:
::
::::  ~sivtyv-barnel, ~fyr
  ::
:-  %ask
|=  [^ ~ ~]
^-  (sole-result ,[%txt wain])
=|  txt=wain
|-
%+  sole-lo  [%& %write ""]
%+  sole-go  (star prn)
|=  tay=tape
?~  tay  (sole-so %txt (flop txt))
%+  sole-yo  `tank`leaf/tay
^$(txt [(crip tay) txt])
