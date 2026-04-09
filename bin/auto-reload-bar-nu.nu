#!/bin/nu

const script_name = path self | path basename

let processes = ps -l
  | where name !~ $env.EDITOR and command =~ $script_name
  | length

if $processes > 1 {
  print --stderr "Already running"
  exit 1
}

print "Starting up..."
socat -U - UNIX-CONNECT:($env.XDG_RUNTIME_DIR)/hypr/($env.HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock
  | each { $in }
  | where { $in =~ 'monitoraddedv2' }
  | each {
    try {
      killall gjs # hyprpanel 
    } catch { |err|
      print $err.msg
    }

    try {
      job spawn { hyprpanel }
    } catch { |err|
      print $err.msg
    }
  }
