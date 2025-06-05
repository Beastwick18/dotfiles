source `./autoload.nu`
source `./completions.nu`

# fg -> unfreeze background job like POSIX terminals
alias yay = paru
alias fg = try { job unfreeze (job list | last | get id) } catch { print "fg: no current job" }
alias config = dot config

source ~/.config/nushell/themes/catppuccin_mocha.nu


# Hide banner
$env.config.show_banner = false
