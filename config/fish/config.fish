# Improved fish config with better error handling

# Check if we're in Warp terminal
if test "$TERM_PROGRAM" != "WarpTerminal"
    ##### PLUGINS AND TOOLS (DISABLED FOR WARP) - BELOW
    
    if status is-interactive
        # Commands to run in interactive sessions can go here
        echo "Setting up interactive fish session (non-Warp)"
    end
    
    # ASDF configuration - with error checking
    if command -v asdf >/dev/null 2>&1
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
    end

    # Direnv - with error checking
    if command -v direnv >/dev/null 2>&1
        direnv hook fish | source
        set -g direnv_fish_mode eval_on_arrow
    end

    # Starship prompt - with error checking
    if command -v starship >/dev/null 2>&1
        starship init fish | source
    end
    
    # TheFuck - with error checking
    if command -v thefuck >/dev/null 2>&1
        thefuck --alias | source
    end

    # Custom abbreviations
    abbr --add "csr" "dotnet run --project (find **/ClockShark.MVC.csproj)"

    # NVM function - with error checking
    if test -f ~/.nvm/nvm.sh; and command -v bass >/dev/null 2>&1
        function nvm
            bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
        end
        
        # Try to use default node version, but don't fail if it doesn't work
        if functions -q nvm
            nvm use default --silent 2>/dev/null; or true
        end
    end
    
    # Ensure Claude Code is available by adding nvm node path directly
    if test -d ~/.nvm/versions/node/v22.16.0/bin
        fish_add_path ~/.nvm/versions/node/v22.16.0/bin
    end

    # Trunk (Rust WASM bundler)
    if test -d ~/.asdf/installs/rust/1.77.0/bin
        fish_add_path ~/.asdf/installs/rust/1.77.0/bin
    end

    # Docker aliases
    if command -v podman >/dev/null 2>&1
        function docker
            podman $argv
        end
    end
    
    if command -v podman-compose >/dev/null 2>&1
        function docker-compose
            podman-compose $argv
        end
    end

    ##### PLUGINS AND TOOLS (DISABLED FOR WARP) - ABOVE
else
    # We're in Warp - minimal setup
    if status is-interactive
        echo "Fish running in Warp Terminal"
    end
end
eval "$(/opt/homebrew/bin/brew shellenv)"
