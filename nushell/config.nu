source `./autoload.nu`
source `./completions.nu`

# fg -> unfreeze background job like POSIX terminals
# alias fg = try { job unfreeze (job list | sort-by id | last | get id) } catch { print "fg: no current job" }
alias yay = paru
alias config = dot config
alias zj = zellij
alias click = sudo -E osu-clicker --volume 1.2 --hit-file /home/brad/repos/osu-clicker/assets/hit.wav -d 0 -z KEY_X -x KEY_C -b 64
alias osu-auto-gamma = osu-auto-gamma
alias ls = ls -a
alias df = dysk

alias yarn = yarn --use-yarnrc $"($env.XDG_CONFIG_HOME)/yarn/config"
alias wget = wget --hsts-file=$"($env.XDG_DATA_HOME)/wget-hsts"
alias nvidia-settings = nvidia-settings --config=$"($env.XDG_CONFIG_HOME)/nvidia/settings"
alias ssh = kitten ssh

def config-reload [] {
  exec nu
}

def fg [] {
  try {
    job unfreeze (job list | get id | math max)
  } catch {
    print "fg: no current job"
  }
}

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
