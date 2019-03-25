::  Primitive tester for the String library.
/+  string
!:
|_  {bowl:gall $~}

++  poke-noun
  |=  *
  ^-  {(list move) _+>.$}
  =+  ^=  results  :~

  ~&  %sum
  (test sum:string "123" 150)

  ~&  %tail
  (test tail:string ["0123" 2] "23")
  (test tail:string ["0123" 5] "0123")
  (test tail:string ["0123" 0] "")

  ~&  %get
  (test get:string ["0123" 1 3] "12")
  (test get:string ["0123" 2 1] "")
  (test get:string ["0123" 3 6] "3")

  ~&  %starts-with
  (test starts-with:string ["abcd" "ab"] &)
  (test starts-with:string ["abcd" "bc"] |)

  ~&  %ends-with
  (test ends-with:string ["abcd" "cd"] &)
  (test ends-with:string ["abcd" "bc"] |)

  ~&  %contains
  (test contains:string ["abcd" "bc"] &)
  (test contains:string ["abcd" "de"] |)

  ~&  %contains-any
  (test contains-any:string ["abcd" ["de" "bc" ~]] &)
  (test contains-any:string ["abcd" ["de" "fg" ~]] |)

  ~&  %contains-all
  (test contains-all:string ["abcd" ["ab" "bc" ~]] &)
  (test contains-all:string ["abcd" ["ab" "de" ~]] |)

  ~&  %find-last
  (test find-last:string ["0103" "0"] [~ 2])
  (test find-last:string ["0103" "4"] ~)

  ~&  %find-nth
  (test find-nth:string ["0103" "0" 2] [~ 2])
  (test find-nth:string ["0103" "0" 3] ~)

  ~&  %find-first-any
  (test find-any:string ["012345" ["12" "2" "4" ~]] [~ 1 "12"])
  (test find-any:string ["012345" ["a" "b" "c" ~]] ~)

  ~&  %find-last-any
  (test find-last-any:string ["012345" ["1" "2" "34" ~]] [~ 3 "34"])
  (test find-last-any:string ["012345" ["a" "b" "c" ~]] ~)

  ~&  %trim-left
  (test trim-left:string " a b  c  " "a b  c  ")

  ~&  %trim-right
  (test trim-right:string " a b  c  " " a b  c")

  ~&  %trim
  (test trim:string " a b  c  " "a b  c")

  ~&  %delete
  (test delete:string ["0123" 1 3] "03")
  (test delete:string ["0123" 2 5] "01")

  ~&  %delete-first
  (test delete-first:string ["0103" "0"] "103")
  (test delete-first:string ["0103" "4"] "0103")

  ~&  %delete-last
  (test delete-last:string ["0103" "0"] "013")
  (test delete-last:string ["0103" "4"] "0103")

  ~&  %delete-nth
  (test delete-nth:string ["0103" "0" 2] "013")
  (test delete-nth:string ["0103" "0" 3] "0103")

  ~&  %delete-all
  (test delete-all:string ["0103" "0"] "13")
  (test delete-all:string ["0103" "4"] "0103")

  ~&  %replace
  (test replace:string ["0123" [1 3] "abc"] "0abc3")
  (test replace:string ["0123" [2 5] "abc"] "01abc")

  ~&  %replace-first
  (test replace-first:string ["0103" "0" "abc"] "abc103")
  (test replace-first:string ["0103" "4" "abc"] "0103")

  ~&  %replace-last
  (test replace-last:string ["0103" "0" "abc"] "01abc3")
  (test replace-last:string ["0103" "4" "abc"] "0103")

  ~&  %replace-nth
  (test replace-nth:string ["0103" "0" "abc" 2] "01abc3")
  (test replace-nth:string ["0103" "0" "abc" 3] "0103")

  ~&  %replace-all
  (test replace-all:string ["0103" "0" "abc"] "abc1abc3")
  (test replace-all:string ["0103" "4" "abc"] "0103")

  ~&  %split
  (test split:string ["ab, c!, 1,2 " ", "] ["ab" "c!" "1,2 " ~])

  ~&  %glue
  (test glue:string [["a" "bc" "d" ~] ", "] "a, bc, d")
  (test glue:string [["a" "bc" "d" ~] ""] "abcd")

  ==
  ~?  (levy (ly results) |=(r/? r))  [%all-passed "(:"]
  [~ +>.$]

++  test
  |*  {func/gate args/* expect/*}
  ^-  ?
  =+  output=(func args)
  =+  ^=  res  =(output expect)
  ~?  !res  :*
    %failed
    %with-args    args
    %expected     expect
    %got          output
  ==
  res
--
