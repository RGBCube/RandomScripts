#!/usr/bin/env nu

def main [
  --org (-o): string = ""
  --user (-u): string = ""
] {
  let path = if not ($org | is-empty) {
    "orgs/" + $org
  } else if not ($user | is-empty) {
    "users/" + $user
  } else {
    ""
  }

  if ($path | is-empty) {
    echo $"(ansi red)error:(ansi reset) either org or user must be supplied"
    exit 1
  }

  # Couldn't get parallel to work correctly so whatever.
  http get https://api.github.com/($path)/repos
  | each { git clone $"https://github.com/($in.full_name)" }

  print "\nDone!"
}
