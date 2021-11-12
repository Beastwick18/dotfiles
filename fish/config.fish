# ~/.config/fish/config.fish

fish_vi_key_bindings # Enable vi key bindings

# User defined functions

function mkcd
    mkdir -pv $argv[1]
    cd $argv[1]
end

# Move file to dotfiles, create link
function dotfile
    mv $argv[1] ~/dotfiles/(basename $argv[1])
    ln -nfs ~/dotfiles/(basename $argv[1]) $argv[1]
end

# 'sudo !!' for fish
function sudo!!
    eval sudo $history[1]
end
 
# My function for swapping two files, with swp files
function swapFiles 
    mv $argv[1] (echo $argv[1]).swp
    mv $argv[2] (echo $argv[2]).swp
    mv (echo $argv[2]).swp $argv[1]
    mv (echo $argv[1]).swp $argv[2]
end

function setRandomWallpaper
    set -l matches ~/Pictures/kittyWallpapers/*.png
    # Check if any wallpapers (other than current) exist
    if test -z "$matches" # If they do, swap current with random background
    else
        random (date +%N)
        set -e FILE1
        set -l FILE1 (random choice ~/Pictures/kittyWallpapers/*.png)
        if set -q FILE1
            # swapFiles $FILE1 ~/Pictures/kittyWallpapers/current/current.png
            cp $FILE1 ~/Pictures/kittyWallpapers/current/current.png
        end
    end
end

# Set default fish terminal title
function fish_title
    set -q argv[1]; or set argv fish
    set -l dir (fish_prompt_pwd_dir_length=1 prompt_pwd)
    echo "$argv ($dir)";
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
alias nv="nvim"
alias g="git"
alias mkd="mkdir -pv"
alias sdnf="sudo dnf"
alias mnt="mount | grep -E ^/dev | column -t"
alias ghist="history | grep"

# Kitten aliases
alias icat="kitty +kitten icat"
alias ssh="kitty +kitten ssh"

# Abbreviations
    # Config file abbreviations
abbr fishc nvim ~/.config/fish/config.fish
abbr kittyc nvim ~/.config/kitty/kitty.conf
abbr kittyUpdate 'curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
abbr nvimc nvim ~/.config/nvim/init.vim
abbr awesomec nvim ~/.config/awesome/rc.lua
abbr mntpi sshfs pi@sbc3662:/home/pi/Desktop/CSE2312 ~/rpi
abbr umntpi umount ~/rpi
abbr sshpi ssh pi@sbc3662
abbr sshomega ssh -oKexAlgorithms=+diffie-hellman-group-exchange-sha1 sbc3662@omega.uta.edu

# Color theme
set -g theme_color_scheme dracula

