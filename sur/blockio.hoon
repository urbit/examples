::
::::  /hoon/blockio/sur
  ::
|%
++  currency                                            ::>  supported coins
  ?($btc $ltc $doge $btc-test $ltc-test $doge-test)     ::
++  error  tape                                         ::<  error result
++  balance                                             ::>  balance info
  $:  coin/currency                                     ::<  network
      have/tape                                         ::<  confirmed balance
      pend/tape                                         ::<  unconfirmed balance
  ==                                                    ::
++  withdrawal                                          ::>  withdrawal info
  $:  coin/currency                                     ::<  network
      txid/tape                                         ::<  transaction
      paid/tape                                         ::<  total withdrawn
      sent/tape                                         ::<  amount to target
      feen/tape                                         ::<  network fee
      feeb/tape                                         ::<  block.io fee
  ==                                                    ::
++  secrets  (pair (map currency @t) @t)                ::<  secrets data format
--
