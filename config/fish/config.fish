if status is-interactive
    # Commands to run in interactive sessions can go here
end

source /opt/homebrew/opt/asdf/libexec/asdf.fish
direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow

starship init fish | source