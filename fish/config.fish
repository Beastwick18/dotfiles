# ~/.config/fish/config.fish

fish_vi_key_bindings # Enable vi key bindings

# User defined functions

# Move file to dotfiles, create link
function dotfile
    mv $argv[1] ~/dotfiles/(basename $argv[1])
    ln -nfs ~/dotfiles/(basename $argv[1]) $argv[1]
end

# 'sudo !!' for fish
function sudo!!
    eval sudo $history[1]
end

function swapFiles # My function for swapping two files, with tmp files
    mv $argv[1] (echo $argv[1]).swp
    mv $argv[2] (echo $argv[2]).swp
    mv (echo $argv[2]).swp $argv[1]
    mv (echo $argv[1]).swp $argv[2]
end

function setRandomWallpaper
    set -l matches ~/Pictures/kittyWallpapers/*.png
    # Check if any wallpapers (other than current) exist
    if not test -z $matches # If they do, swap current with random background
        random (date +%N)
        set -e FILE1
        set -l FILE1 (random choice ~/Pictures/kittyWallpapers/*.png)
        if set -q FILE1
            swapFiles $FILE1 ~/Pictures/kittyWallpapers/current/current.png
        end
    end
end

# Greeting (and initialization)
function fish_greeting
    # Set random background for kitty
    setRandomWallpaper
    
    # Show catfetch
    catfetch
end

# Keybindings
function fish_user_key_bindings
    # Vim keybinds in insert mode
    bind -M insert \cl forward-char
    bind -M insert \ch backward-char
    bind -M insert \ck history-search-backward
    bind -M insert \cj history-search-forward
    
    # Ctrl f for accepting autosuggestion
    bind -M insert \cf forward-char
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Aliases
alias v="nvim"
alias g="git"
alias mkd="mkdir -pv"
alias sdnf="sudo dnf"
alias mnt="mount | grep -E ^/dev | column -t"
alias ghist="history | grep"

# Abbreviations
    # Config file abbreviations
abbr fishc nvim ~/.config/fish/config.fish
abbr kittyc nvim ~/.config/kitty/kitty.conf
abbr kittyUpdate 'curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
abbr nvimc nvim ~/.config/nvim/init.vim
abbr awesomec nvim ~/.config/awesome/rc.lua

# Color theme
set -g theme_color_scheme dracula

