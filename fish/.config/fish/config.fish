if status is-interactive
    # Commands to run in interactive sessions can go here
end
function fish_greeting
    echo "Hi, Luoqi!"
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
function dw
    cd $HOME/Documents/work
end

function dww
    cd $HOME/Documents/work/猪场3.0版/03_开发/源码/Web端/pigMan3.1
end

function lg
    lazygit
end

function updatesystem
    sudo pacman -Syyu --noconfirm && yay -Syyu --noconfirm
end

set -Ux HTTP_PROXY http://127.0.0.1:7890
set -Ux HTTPS_PROXY http://127.0.0.1:7890
set -Ux ALL_PROXY http://127.0.0.1:7890
# set -Ux HTTP_PROXY http://10.1.1.22:7897
# set -Ux HTTPS_PROXY http://10.1.1.22:7897
# set -Ux ALL_PROXY http://10.1.1.22:7897
set -Ux EDITOR nvim
set -Ux VISUAL neovide
set -Ux PATH $HOME/.local/bin $PATH
set -Ux HSA_OVERRIDE_GFX_VERSION 10.3.0
# fnm
# node version manager
fnm env --use-on-cd --shell fish | source
# starship
starship init fish | source
# fzf
fzf --fish | source
# zoxide
zoxide init fish | source
set -gx TERM xterm-256color
set -gx PATH $HOME/.cargo/bin $PATH
