=<  (fib 4.000.000)

|%
++  fib
  |=  lim=@
  =+  [fst=1 scd=2]
  |-
  ?.  (lte scd lim)
    ~
  ?:  =((mod scd 2) 0)
    (add scd $(fst scd, scd (add fst scd)))
  $(fst scd, scd (add fst scd))

  :: ;:(add fst scd $(fst scd, scd (add fst scd)))   ::  ;: folds
--
