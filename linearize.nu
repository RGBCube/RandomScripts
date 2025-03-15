#!/usr/bin/env nu

let root = input "enter linearized directory path: "
mkdir $root

if (ls $root | is-not-empty) {
  print $"(ansi red)directory not empty, delete it and try again(ansi reset)"
  exit 1
}

let source = input "enter directory to linearize: "

ls ...(glob $"($source)/**/*")
| where type == file
| group-by size | values
| each {|group|
  if ($group | length) == 1 {
    return $group
  }

  let by_identity = $group
  | each { insert hash (open $in.name | hash sha256) }
  | group-by hash | values

  $by_identity
  | filter { ($in | length) > 1 }
  | each {|entries|
    print $"found identical files: \n- (ansi red)($entries | get name | str join $'(ansi reset)\n- (ansi red)')(ansi reset)"
  }

  $by_identity
  | each { get 0 }
}
| flatten
| each {|entry|
  let parse = $entry.name | path parse

  let date = $entry.modified | format date "%Y-%m-%dT%H:%M:%S"
  let name = $"($date)-($entry.hash? | default "unique" | str substring ..6)-($parse.stem).($parse.extension)"

  print $"creating (ansi green)($name)(ansi reset)"
  ln $entry.name ($root | path join $name)
}
| ignore
