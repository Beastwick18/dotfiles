source `./autoload.nu`
source `./completions.nu`

# fg -> unfreeze background job like POSIX terminals
alias yay = paru
alias fg = try { job unfreeze (job list | last | get id) } catch { print "fg: no current job" }
alias config = dot config
alias hx = helix

alias yarn = yarn --use-yarnrc $"($env.XDG_CONFIG_HOME)/yarn/config"
alias wget = wget --hsts-file=$"($env.XDG_DATA_HOME)/wget-hsts"
alias nvidia-settings = nvidia-settings --config=$"($env.XDG_CONFIG_HOME)/nvidia/settings"
alias ssh = kitten ssh

def "ssh pf" [address: string, port: number, host_port?: number] {
  ssh -L $"($host_port | default $port):localhost:($port)" -Nf $address
}

def "ssh pf stop" [port: number] {
  try {
    ps -l | where name =~ 'ssh' | where command =~ $'($port):localhost' | get pid | kill -9 $in.0
  } catch {
    print -e $"Could not stop ssh port-forwarding on port ($port)"
  }

}

def "ssh pf list" [] {
  ps -l
    | where name =~ 'ssh'
    | where command =~ 'ssh.*-L\s+\d+:localhost:\d+'
    | get command
    | each {
        $in
          | str replace -r '.*\s(\d+):localhost:(\d+)\s.*\s(\w+)$' '$3,$1,$2'
          | split column ',' host local_port remote_port
          | get 0
      }
    | uniq
}

source ~/.config/nushell/themes/catppuccin_mocha.nu


# Hide banner
$env.config.show_banner = false
