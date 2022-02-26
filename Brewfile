# 'brew tap'
tap "homebrew/autoupdate"
tap "homebrew/cask-fonts"
# 'brew tap' with custom Git URL
#tap "user/tap-repo", "https://user@bitbucket.org/user/homebrew-tap-repo.git"
# set arguments for all 'brew install --cask' commands
#cask_args appdir: "~/Applications", require_sha: true

# 'brew install --cask'
cask "visual-studio-code"
cask "joplin"
cask "microsoft-edge"
cask "firefox"
cask "hammerspoon"
cask "microsoft-remote-desktop"
cask "font-caskaydia-cove-nerd-font"
# 'brew install --cask --appdir=~/my-apps/Applications'
#cask "firefox", args: { appdir: "~/my-apps/Applications" }
# always upgrade auto-updated or unversioned cask to latest version even if already installed
#cask "opera", greedy: true
# 'brew install --cask' only if '/usr/libexec/java_home --failfast' fails
#cask "java" unless system "/usr/libexec/java_home --failfast"

# 'brew install'
brew "asdf"
brew "cloudflare/cloudflare/cloudflared"
brew "fish"
brew "gettext"
brew "chezmoi"
brew "rcm"
brew "starship"
# 'brew install --with-rmtp', 'brew services restart' on version changes
#brew "denji/nginx/nginx-full", args: ["with-rmtp"], restart_service: :changed
# 'brew install', always 'brew services restart', 'brew link', 'brew unlink mysql' (if it is installed)
#brew "mysql@5.6", restart_service: true, link: true, conflicts_with: ["mysql"]
