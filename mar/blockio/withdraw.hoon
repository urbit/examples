::
::::  /hoon/withdraw/blockio/mar
  ::
/-  blockio
/+  blockio, httr-to-json
[. blockio]
|_  wil/(each withdrawal error)
::
++  grab                                                ::>  convert to balance
  |%
  ++  noun  &+withdrawal                                ::<  ...from noun
  ::
  ++  httr                                              ::<  ...from http result
    |=  hit/^httr
    ::NOTE  because httr-to-json errors if not status 2xx.
    (json (httr-to-json hit(p 200)))
  ::
  ++  json                                              ::>  ...from json
    =>  [jo .]
    |=  jon/json
    ^-  (each withdrawal error)
    =+  ((ot data+(om sa) ~) jon)
    ?~  -  ::  if parsing failed, assume local signing is demanded.
      |+"Block.io pin not set! Required for transactions. `pin [your-secret]`"
    =+  (need -)
    ?:  (~(has by -) 'error_message')
      |+(~(got by -) 'error_message')
    :-  %&
    :*  (net-cur (~(got by -) 'network'))
        (~(got by -) 'txid')
        (~(got by -) 'amount_withdrawn')
        (~(got by -) 'amount_sent')
        (~(got by -) 'network_fee')
        (~(got by -) 'blockio_fee')
    ==
  --
--
