#!/usr/bin/env nu

print -n $"Çekiliş sonucu: (ansi red) "

(random int 0..1500 | into string)
| split chars
| each {|n|
  for $i in 0..($n | into int) {
    print -n "\b"
    print -n $i

    sleep 300ms
  }

  print -n $n
}

print "\b "
