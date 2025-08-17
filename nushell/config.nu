source `./autoload.nu`
source `./completions.nu`

# fg -> unfreeze background job like POSIX terminals
alias yay = paru
alias fg = try { job unfreeze (job list | last | get id) } catch { print "fg: no current job" }
alias config = dot config

alias yarn = yarn --use-yarnrc $"($env.XDG_CONFIG_HOME)/yarn/config"
alias wget = wget --hsts-file=$"($env.XDG_DATA_HOME)/wget-hsts"
alias nvidia-settings = nvidia-settings --config=$"($env.XDG_CONFIG_HOME)/nvidia/settings"

source ~/.config/nushell/themes/catppuccin_mocha.nu


# Hide banner
$env.config.show_banner = false
