::
::::  /hoon/balance/blockio/mar
  ::
/-  blockio
/+  blockio, httr-to-json
[. blockio]
|_  bal/(each balance error)
::
++  grab                                                ::>  convert to balance
  |%
  ++  noun  &+balance                                   ::<  ...from noun
  ::
  ++  httr  (cork httr-to-json json)                    ::<  ...from http result
  ::
  ++  json                                              ::>  ...from json
    =>  [jo .]
    |=  jon/json
    ^-  (each balance error)
    =+  (need ((ot data+(om sa) ~) jon))
    ?:  (~(has by -) 'error_message')
      |+(~(got by -) 'error_message')
    :-  %&
    :+  (net-cur (~(got by -) 'network'))
      (~(got by -) 'available_balance')
    (~(got by -) 'pending_received_balance')
  --
--
