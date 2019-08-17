::
::::  /hoon/blockio/lib
  ::
/-  blockio
[. ^blockio]
|%
++  net-cur                                             ::<  network to currency
  |=  net/tape
  ^-  currency
  ?:  =(net "BTC")        %btc
  ?:  =(net "LTC")        %ltc
  ?:  =(net "DOGE")       %doge
  ?:  =(net "BTCTEST")    %btc-test
  ?:  =(net "LTCTEST")    %ltc-test
  ?:  =(net "DOGETEST")   %doge-test
  ~&([%strange-net net] !!)
::
++  cur-net
  |=  cur/currency
  ^-  tape
  ?-  cur
    $btc        "BTC"
    $ltc        "LTC"
    $doge       "DOGE"
    $btc-test   "BTCTEST"
    $ltc-test   "LTCTEST"
    $doge-test  "DOGETEST"
  ==
--
