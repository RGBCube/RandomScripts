#!/usr/bin/env nu

print -n $"Lottery number: (ansi red) "

random int 0..1500
| into string
| split chars
| each {|n|
  for $i in 0..($n | into int) {
    print --no-newline $"\b($i)"

    sleep 300ms
  }

  print --no-newline $n
}

print "\b "
