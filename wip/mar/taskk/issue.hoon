::::  /hoon/issue/taskk/mar
  ::
  ::
  ::
/-  taskk-phase
::
|_  $:
  boa/@t                                         :: board name
  tit/@t                                         :: issue title
  des/@t                                         :: issue description
  pha/taskk-phase
  aut/@p                                         :: issue author
  ass/@p                                         :: issue assignee
    ==                                         
::
++  grab                                         ::  convert from
  |%
  ++  noun  {@t @t @t @ud @p @p}               ::  clam from %noun
  --
--
