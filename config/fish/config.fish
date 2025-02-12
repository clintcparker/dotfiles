if status is-interactive
    # Commands to run in interactive sessions can go here
end


# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

direnv hook fish | source
set -g direnv_fish_mode eval_on_arrow

starship init fish | source
thefuck --alias | source 

# asdf_update_dotnet_home     

abbr --add "csr" "dotnet run --project (find **/ClockShark.MVC.csproj)"

