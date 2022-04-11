# ~/.config/fish/config.fish

# fish_vi_key_bindings # Enable vi key bindings

# User defined functions

function kittybg
    function list
        tput bold
        tput smul
        printf "Next:\n"
        tput sgr0
        set -l NEXT (ls -1 /home/$USER/Pictures/kittyWallpapers/ | grep '.next' | awk -F[.][n][e][x][t]\$ '{print $1}')
        tput setaf 6; echo -e "\e]8;;file:///home/$USER/Pictures/kittyWallpapers/$NEXT.png\a$NEXT\e]8;;\a"
        tput sgr0
        
        tput bold
        tput smul
        echo -e "\n\e]8;;file:///home/$USER/Pictures/kittyWallpapers/\aEnabled:\e]8;;\a"
        tput sgr0
        tput setaf 10; ls -1 /home/$USER/Pictures/kittyWallpapers/ | grep '.png' | sed -e 's/\.png$//' | cat
        tput sgr0
        tput bold
        tput smul
        echo -e "\n\e]8;;file:///home/$USER/Pictures/kittyWallpapers/disabled/\aDisabled:\e]8;;\a"
        tput sgr0
        tput setaf 1; ls -1 /home/$USER/Pictures/kittyWallpapers/disabled | sed -e 's/\.png$//' | cat
        tput sgr0
        
        functions -e list
    end
    if test (count $argv) -lt 1 -o "$argv[1]" = "l" -o "$argv[1]" = "list" -o
        list
    else if test "$argv[1]" = "r" -o "$argv[1]" = "random"
        setRandomWallpaper
        
        tput bold
        tput smul
        printf "Next:\n"
        tput sgr0
        set -l NEXT (ls -1 /home/$USER/Pictures/kittyWallpapers/ | grep '.next' | awk -F[.][n][e][x][t]\$ '{print $1}')
        tput setaf 6; echo -e "\e]8;;file:///home/$USER/Pictures/kittyWallpapers/$NEXT.png\a$NEXT\e]8;;\a"
        tput sgr0
        
    else if test (count $argv) -lt 2
        echo "Usage: kittybg [command] [name]"
        return
    else if test "$argv[1]" = "e" -o "$argv[1]" = "enable"
        if test -e "/home/$USER/Pictures/kittyWallpapers/disabled/$argv[2].png"
            mv /home/$USER/Pictures/kittyWallpapers/disabled/$argv[2].png /home/$USER/Pictures/kittyWallpapers/
        else
            echo "There is no disabled wallpaper named $argv[2].png"
        end
    else if test "$argv[1]" = "d" -o "$argv[1]" = "disable"
        if test -e "/home/$USER/Pictures/kittyWallpapers/$argv[2].png"
            mv /home/$USER/Pictures/kittyWallpapers/$argv[2].png /home/$USER/Pictures/kittyWallpapers/disabled/
        else
            echo "There is no enabled wallpaper named $argv[2].png"
        end
    else if test "$argv[1]" = "s" -o "$argv[1]" = "set"
        if test -e "/home/$USER/Pictures/kittyWallpapers/$argv[2].png"
            cp /home/$USER/Pictures/kittyWallpapers/$argv[2].png /home/$USER/Pictures/kittyWallpapers/current/current.png
            rm /home/$USER/Pictures/kittyWallpapers/*.next
            touch /home/$USER/Pictures/kittyWallpapers/$argv[2].next
            
            tput bold
            tput smul
            printf "Next:\n"
            tput sgr0
            set -l NEXT (ls -1 /home/$USER/Pictures/kittyWallpapers/ | grep '.next' | awk -F[.][n][e][x][t]\$ '{print $1}')
            tput setaf 6; echo -e "\e]8;;file:///home/$USER/Pictures/kittyWallpapers/$NEXT.png\a$NEXT\e]8;;\a"
            tput sgr0
        else if test -e "/home/$USER/Pictures/kittyWallpapers/disabled/$argv[2].png"
            cp /home/$USER/Pictures/kittyWallpapers/disabled/$argv[2].png /home/$USER/Pictures/kittyWallpapers/current/current.png
            rm /home/$USER/Pictures/kittyWallpapers/*.next
            touch /home/$USER/Pictures/kittyWallpapers/$argv[2].next
            
            tput bold
            tput smul
            printf "Next:\n"
            tput sgr0
            set -l NEXT (ls -1 /home/$USER/Pictures/kittyWallpapers/ | grep '.next' | awk -F[.][n][e][x][t]\$ '{print $1}')
            tput setaf 6; echo -e "\e]8;;file:///home/$USER/Pictures/kittyWallpapers/disabled/$NEXT.png\a$NEXT\e]8;;\a"
            tput sgr0
        else
            echo "There is no wallpaper named $argv[2].png"
            return
        end
        
    else if test "$argv[1]" = "a" -o "$argv[1]" = "add"
        java -jar /home/$USER/Documents/javaDimmer/Dimmer.jar $argv[2] /home/$USER/Pictures/kittyWallpapers/(echo (basename $argv[2] | string split -r -m1 .)[1]).png
    else
        echo "Usage: kittybg -ledsr [name]"
    end
end

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
    set -l matches /home/$USER/Pictures/kittyWallpapers/*.png
    # Check if any wallpapers (other than current) exist
    if test -z "$matches" # If they do, swap current with random background
    else
        random (date +%N)
        set -e FILE1
        set -l FILE1 (random choice /home/$USER/Pictures/kittyWallpapers/*.png)
        if set -q FILE1
            # swapFiles $FILE1 ~/Pictures/kittyWallpapers/current/current.png
            cp $FILE1 /home/$USER/Pictures/kittyWallpapers/current/current.png
            rm /home/$USER/Pictures/kittyWallpapers/*.next
            touch (echo "$FILE1" | sed -e 's/\.png$//').next
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
alias kbg="kittybg"

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

fish_add_path $HOME/apps/kotlin/bin
