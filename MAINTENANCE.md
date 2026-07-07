# Brewfile maintenance ritual

The Brewfile in this repo is the documented truth of what's on this Mac
(symlinked at `~/.Brewfile`). Keep it true with three habits — each under
2 minutes, or you won't do them.

## 1. When you install something
Right after `brew install X` (or `--cask`, or `mas install`):
1. Add one line to the matching `## ──` section of `Brewfile`, with a comment
   saying what it's *for* (your reason, not the upstream blurb).
2. `git -C ~/.dotfiles commit -am "brewfile: add X"`

When you uninstall something, delete its line the same way.

## 2. Monthly-ish drift check
```fish
brew bundle check --global --verbose   # is anything in the file missing from disk?
brew bundle dump --file=/tmp/bf --force; and begin
  # anything on disk missing from the file?
  for t in brew cask mas vscode
    comm -13 (grep "^$t " ~/.Brewfile | sed 's/,.*//' | sort | psub) \
             (grep "^$t " /tmp/bf   | sed 's/,.*//' | sort | psub)
  end
end
```
Anything the second command prints is installed but undocumented — give it a
line and a comment (or uninstall it).

## 3. Cleanup day (when it comes)
The 2026-07-02 audit left `CANDIDATE FOR REMOVAL` flags on ~83 lines
(grep the file). To act on one:
1. `brew uninstall X` (casks: consider `--zap`), then delete its line, commit.
2. Special cases, in order:
   - `redis` — `brew services stop redis` first (it's running).
   - `ipfs` / `lasso` Caskroom husks — stale renamed entries that share .app
     bundles with `ipfs-desktop` / `lasso-app`. Remove the husk directories from
     `/opt/homebrew/Caskroom/` by hand rather than `brew uninstall`, or you'll
     take the live app with them.
   - Orphaned deps (the 54 flagged in the Dependencies section) — after
     protecting git with `brew tab --installed-on-request git`, one
     `brew autoremove` clears them all; then delete their lines.
3. Finish with `brew bundle check --global` to confirm file ↔ disk agreement.

## Fresh machine
```fish
xcode-select --install
# install Homebrew (brew.sh), then:
brew bundle --global    # taps → formulae → casks → mas apps → VS Code extensions
```
`mas` requires being signed into the App Store first; VS Code extension lines
need the `code` CLI on PATH (installing the cask provides it).
