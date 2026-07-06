# ~/.dotfiles/Brewfile — everything Homebrew manages on this Mac
#
# Rebuilt 2026-07-02 by the brew-cleanup project (specs + inventory:
# ~/claude-code-work-dirs/brew-cleanup). Symlinked at ~/.Brewfile, so
# `brew bundle --global` restores it all; `mas` and VS Code (`code`) must be
# present for the mas/vscode lines.
#
# Conventions:
#   - Grouped by purpose. Auto-installed dependencies live in their own
#     section near the bottom, each marked "(dep of …)".
#   - "CANDIDATE FOR REMOVAL" = flagged during the 2026-07-02 audit for a
#     future cleanup pass. Nothing was uninstalled; every flagged line still
#     reflects something installed today.
#   - Maintenance ritual: see MAINTENANCE.md next to this file.

## ── Taps ─────────────────────────────────────────────────────────────
tap "azure/azd"                   # source of azd (Azure Developer CLI)
tap "razvandimescu/tap"           # source of numa
tap "cloudflare/cloudflare"       # CANDIDATE FOR REMOVAL: provides nothing installed (cloudflared now ships from homebrew/core)
tap "domt4/autoupdate"            # CANDIDATE FOR REMOVAL: brew autoupdate was never configured; maintenance is manual by choice
tap "fermyon/tap"                 # CANDIDATE FOR REMOVAL: provides nothing installed (old Spin/WebAssembly experiment?)

## ── Shell & everyday CLI ─────────────────────────────────────────────
brew "fish"                       # Login shell
brew "starship"                   # Cross-shell prompt
brew "gum"                        # Pretty prompts/pickers for shell scripts
brew "thefuck"                    # Corrects the previous mistyped command
brew "coreutils"                  # GNU file/shell/text utilities (g-prefixed)
brew "difftastic"                 # Syntax-aware diff
brew "jq"                         # Command-line JSON processor
brew "cloc"                       # Count lines of code
brew "mas"                        # Mac App Store CLI — installs the mas section below
brew "rcm"                        # Dotfile manager — this repo is deployed with it (see rcrc)
brew "asdf"                       # Multi-runtime version manager (see tool-versions)

## ── Git & GitHub ─────────────────────────────────────────────────────
brew "git"                        # PATH git (/opt/homebrew/bin/git). NOTE: brew thinks this is an orphaned dep — do NOT let `brew autoremove` take it; `brew tab --installed-on-request git` would fix the marking
brew "gh"                         # GitHub CLI
brew "git-quick-stats"            # Git repo statistics

## ── Containers & virtualization ──────────────────────────────────────
brew "podman"                     # OCI containers (docker replacement)
brew "podman-compose"             # docker-compose equivalent for podman
brew "qemu"                       # CANDIDATE FOR REMOVAL: VM emulator, likely leftover from pre-applehv podman-machine
brew "socket_vmnet"               # CANDIDATE FOR REMOVAL: rootless networking for QEMU — goes with qemu

## ── Azure / work tooling ─────────────────────────────────────────────
brew "azure-cli"                  # az — general Azure CLI
brew "azd"                        # Azure Developer CLI (azure/azd tap)
brew "powershell"                 # CANDIDATE FOR REMOVAL: duplicate — the powershell CASK below is the kept install

## ── Media & downloads ────────────────────────────────────────────────
brew "ffmpeg"                     # Audio/video convert-anything (pulls in most of the deps section)
brew "yt-dlp"                     # Video/audio downloader

## ── DNS & networking ─────────────────────────────────────────────────
brew "numa"                       # Clint's DNS resolver w/ ad blocking + .numa local proxy (razvandimescu/tap; data in /usr/local/var/numa)
brew "cloudflared"                # CANDIDATE FOR REMOVAL: Cloudflare Tunnel client, service not running
brew "unbound"                    # CANDIDATE FOR REMOVAL: DNS resolver, service not running (numa covers this)
brew "nginx"                      # CANDIDATE FOR REMOVAL: reverse proxy, service not running
brew "redis"                      # CANDIDATE FOR REMOVAL: service IS running — `brew services stop redis` before removing
brew "tor"                        # CANDIDATE FOR REMOVAL: service not running
brew "sshuttle"                   # CANDIDATE FOR REMOVAL: SSH-based VPN, unused
brew "spoof-mac"                  # CANDIDATE FOR REMOVAL: MAC address spoofer, service not running

## ── Pinned old versions ──────────────────────────────────────────────
brew "python@3.10"                # CANDIDATE FOR REMOVAL: EOL Oct 2026, unused
brew "python@3.11"                # CANDIDATE FOR REMOVAL: security-fixes-only upstream, unused
brew "icu4c@76"                   # CANDIDATE FOR REMOVAL: pinned old Unicode lib, nothing depends on it

## ── Misc ─────────────────────────────────────────────────────────────
brew "wimlib"                     # CANDIDATE FOR REMOVAL: Windows .wim imaging — one-off install

## ── koreader build toolchain ─────────────────────────────────────────
# Installed by ~/build-koreader.sh; keep while koreader builds are a thing.
brew "autoconf"                   # configure-script builder
brew "automake"                   # GNU Makefile generator
brew "bash"                       # Modern bash (macOS ships 3.2) — build scripts need it
brew "binutils"                   # GNU binary tools
brew "cmake"                      # Build system
brew "findutils"                  # GNU find/xargs/locate
brew "gnu-getopt"                 # GNU option parsing
brew "libtool"                    # Shared-library build helper
brew "make"                       # GNU make (newer than Xcode's)
brew "meson"                      # Build system
brew "nasm"                       # x86 assembler
brew "pkgconf"                    # pkg-config replacement
brew "sdl3"                       # SDL — koreader emulator window
brew "util-linux"                 # Linux utility collection
# Same-cluster libraries (marked on-request, almost certainly build deps):
brew "glib"                       # Core C application library
brew "gnutls"                     # TLS library
brew "libx11"                     # X11 client library
brew "libxfixes"                  # X11 XFIXES headers
brew "libxi"                      # X Input extension library

## ── Dependencies (installed automatically — not asked for directly) ──
# "(dep of X)" = what needs it today. Orphans are flagged: they arrived as
# deps (mostly ffmpeg's older builds) and nothing installed needs them now;
# `brew autoremove` would clear all 54 of them (git is NOT safe to autoremove,
# see the Git section above).
brew "aom"                        # Codec library for encoding and decoding AV1 video streams — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "aribb24"                    # Library for ARIB STD-B24, decoding JIS 8 bit characters and parsing MPEG-TS — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "brotli"                     # (dep of dotnet, jpeg-xl, powershell) Generic-purpose lossless compression algorithm by Google
brew "ca-certificates"            # (dep of azure-cli, certifi, dotnet, …) Mozilla CA certificate store
brew "cairo"                      # Vector graphics library with cross-device output support — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "capstone"                   # (dep of qemu) Multi-platform, multi-architecture disassembly framework
brew "certifi"                    # (dep of yt-dlp) Mozilla CA bundle for Python
brew "cjson"                      # Ultralightweight JSON parser in ANSI C — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "dav1d"                      # (dep of ffmpeg) AV1 decoder targeted to be small and fast
brew "deno"                       # (dep of yt-dlp) Secure runtime for JavaScript and TypeScript
brew "dotnet"                     # (dep of powershell) .NET Core
brew "dtc"                        # (dep of qemu) Device tree compiler
brew "flac"                       # Free lossless audio codec — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "fontconfig"                 # XML-based font configuration API for X Windows — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "freetype"                   # Software library to render fonts — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "frei0r"                     # Minimalistic plugin API for video effects — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "fribidi"                    # Implementation of the Unicode BiDi algorithm — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "gdbm"                       # (dep of python@3.10) GNU database manager
brew "gettext"                    # (dep of bash, cairo, capstone, …) GNU internationalization (i18n) and localization (l10n) library
brew "giflib"                     # Library and utilities for processing GIFs — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "gmp"                        # (dep of coreutils, git-quick-stats, gnutls, …) GNU multiple precision arithmetic library
brew "graphite2"                  # Smart font renderer for non-Roman scripts — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "harfbuzz"                   # OpenType text shaping engine — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "highway"                    # Performance-portable, length-agnostic SIMD with runtime dispatch — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "icu4c@77"                   # C/C++ and Java libraries for Unicode and globalization — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "icu4c@78"                   # (dep of dotnet, harfbuzz, libass, …) C/C++ and Java libraries for Unicode and globalization
brew "imath"                      # Library of 2D and 3D vector, matrix, and math operations — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "jpeg-turbo"                 # (dep of deno, jpeg-xl, leptonica, …) JPEG image codec that aids compression and decompression
brew "jpeg-xl"                    # New file format for still image compression — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "lame"                       # (dep of ffmpeg, libsndfile, rubberband) High quality MPEG Audio Layer III (MP3) encoder
brew "leptonica"                  # Image processing and image analysis library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libarchive"                 # Multi-format archive and compression library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libass"                     # Subtitle renderer for the ASS/SSA subtitle format — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libb2"                      # Secure hashing function — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libbluray"                  # Blu-Ray disc playback library for media players like VLC — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libdatrie"                  # Double-Array Trie Library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libdeflate"                 # Heavily optimized DEFLATE/zlib/gzip compression and decompression — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libevent"                   # (dep of tor, unbound) Asynchronous event library
brew "libidn2"                    # (dep of gnutls, libmicrohttpd, librist, …) International domain name library (IDNA2008, Punycode and TR46)
brew "libmicrohttpd"              # Light HTTP/1.1 server library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libnghttp2"                 # (dep of unbound) HTTP/2 C Library
brew "libogg"                     # Ogg Bitstream Library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libpng"                     # (dep of aribb24, cairo, fontconfig, …) Library for manipulating PNG images
brew "librist"                    # Reliable Internet Stream Transport (RIST) — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libsamplerate"              # Library for sample rate conversion of audio data — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libscrypt"                  # (dep of tor) Library for scrypt
brew "libslirp"                   # (dep of qemu) General purpose TCP-IP emulator
brew "libsndfile"                 # C library for files containing sampled sound — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libsodium"                  # (dep of azure-cli, zeromq) NaCl networking and cryptography library
brew "libsoxr"                    # High quality, one-dimensional sample-rate conversion library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libssh"                     # (dep of qemu) C library SSHv1/SSHv2 client and server protocols
brew "libtasn1"                   # (dep of gnutls, libmicrohttpd, librist, …) ASN.1 structure parser library
brew "libthai"                    # Thai language support library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libtiff"                    # (dep of deno, jpeg-xl, leptonica, …) TIFF library and utilities
brew "libudfread"                 # Universal Disk Format reader — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libunibreak"                # Implementation of the Unicode line- and word-breaking algorithms — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libunistring"               # (dep of bash, cairo, capstone, …) C string library for manipulating Unicode strings
brew "libusb"                     # (dep of qemu) Library for USB device access
brew "libvidstab"                 # Transcode video stabilization plugin — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libvmaf"                    # (dep of aom, ffmpeg) Perceptual video quality assessment based on multi-method fusion
brew "libvorbis"                  # Vorbis general audio compression codec — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libvpx"                     # (dep of ffmpeg) VP8/VP9 video codec
brew "libxau"                     # (dep of cairo, harfbuzz, libass, …) X.Org: A Sample Authorization Protocol for X
brew "libxcb"                     # (dep of cairo, harfbuzz, libass, …) X.Org: Interface to the X Window System protocol
brew "libxdmcp"                   # (dep of cairo, harfbuzz, libass, …) X.Org: X Display Manager Control Protocol library
brew "libxext"                    # (dep of cairo, harfbuzz, libass, …) X.Org: Library for common extensions to the X11 protocol
brew "libxrender"                 # X.Org: Library for the Render Extension to the X11 protocol — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "libyaml"                    # (dep of azure-cli, dtc, podman-compose, …) YAML Parser
brew "little-cms2"                # (dep of deno, jpeg-xl, leptonica, …) Color management engine supporting ICC profiles
brew "lz4"                        # (dep of binutils, deno, jpeg-xl, …) Extremely Fast Compression algorithm
brew "lzo"                        # (dep of cairo, harfbuzz, libass, …) Real-time data compression library
brew "m4"                         # (dep of autoconf, automake, libtool) Macro processing language
brew "mbedtls"                    # Cryptographic & SSL/TLS library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "mbedtls@3"                  # Cryptographic & SSL/TLS library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "mpdecimal"                  # (dep of azure-cli, meson, podman-compose, …) Library for decimal floating point arithmetic
brew "mpg123"                     # MP3 player for Linux and UNIX — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "ncurses"                    # (dep of bash, qemu) Text-based UI library
brew "nettle"                     # (dep of gnutls, libmicrohttpd, librist, …) Low-level cryptographic library
brew "ninja"                      # (dep of meson) Small build system for use with gyp or CMake
brew "oniguruma"                  # (dep of jq) Regular expressions library
brew "opencore-amr"               # Audio codecs extracted from Android open source project — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "openexr"                    # High dynamic-range image file format — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "openjpeg"                   # Library for JPEG-2000 image manipulation — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "openjph"                    # Open-source implementation of JPEG2000 Part-15 (or JPH or HTJ2K) — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "openssl@3"                  # (dep of azure-cli, dotnet, ffmpeg, …) Cryptography and SSL/TLS Toolkit
brew "opus"                       # (dep of ffmpeg, libsndfile, rubberband) Audio codec
brew "p11-kit"                    # (dep of gnutls, libmicrohttpd, librist, …) Library to load and enumerate PKCS#11 modules
brew "pango"                      # Framework for layout and rendering of i18n text — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "pcre2"                      # (dep of cairo, fish, git, …) Perl compatible regular expressions library with a new API
brew "pixman"                     # (dep of cairo, harfbuzz, libass, …) Low-level library for pixel manipulation
brew "python@3.13"                # (dep of azure-cli, spoof-mac, thefuck) Interpreted, interactive, object-oriented programming language
brew "python@3.14"                # (dep of meson, podman-compose, sshuttle, …) Interpreted, interactive, object-oriented programming language
brew "rav1e"                      # Fastest and safest AV1 video encoder — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "readline"                   # (dep of azure-cli, bash, deno, …) Library for command-line editing
brew "rubberband"                 # Audio time stretcher tool and library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "sdl2-compat"                # (dep of ffmpeg) SDL2 compatibility layer that uses SDL3 behind the scenes
brew "snappy"                     # (dep of qemu) Compression/decompression library aiming for high speed
brew "speex"                      # Audio codec designed for speech — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "sqlite"                     # (dep of azure-cli, deno, meson, …) Command-line interface for SQLite
brew "srt"                        # Secure Reliable Transport — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "svt-av1"                    # (dep of ffmpeg) AV1 encoder
brew "tesseract"                  # OCR (Optical Character Recognition) engine — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "theora"                     # Open video compression format — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "vde"                        # (dep of qemu) Ethernet compliant virtual network
brew "webp"                       # Image format providing lossless and lossy compression for web images — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "x264"                       # (dep of ffmpeg) H.264/AVC encoder
brew "x265"                       # (dep of ffmpeg) H.265/HEVC encoder
brew "xorgproto"                  # (dep of cairo, harfbuzz, libass, …) X.Org: Protocol Headers
brew "xvid"                       # High-performance, high-quality MPEG-4 video library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "xz"                         # (dep of azure-cli, binutils, deno, …) General-purpose data compression with high compression ratio
brew "zeromq"                     # High-performance, asynchronous messaging library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "zimg"                       # Scaling, colorspace conversion, and dithering library — CANDIDATE FOR REMOVAL: orphaned dep, nothing installed needs it
brew "zstd"                       # (dep of binutils, deno, jpeg-xl, …) Zstandard is a real-time compression algorithm

## ── Casks: browsers & routing ────────────────────────────────────────
cask "firefox"                    # Main browser
cask "firefox@developer-edition"  # Firefox dev channel
cask "google-chrome"              # Chrome
cask "microsoft-edge"             # Edge
cask "chromium"                   # CANDIDATE FOR REMOVAL: 5th browser, unused
cask "finicky"                    # Routes links to the right browser (finicky.js in this repo)
cask "browserosaurus"             # Interactive browser picker (kept alongside finicky on purpose)

## ── Casks: development ───────────────────────────────────────────────
cask "visual-studio-code"         # Main editor — the vscode section below restores its extensions
cask "visual-studio-code@insiders" # VS Code prerelease channel
cask "podman-desktop"             # GUI for podman containers
cask "powershell"                 # PowerShell (the kept install; formula copy is flagged above)
cask "font-caskaydia-cove-nerd-font" # Cascadia Code + nerd-font glyphs, for terminal/prompt
cask "azure-data-studio"          # CANDIDATE FOR REMOVAL: retired by Microsoft Feb 2026 (use VS Code MSSQL ext)

## ── Casks: notes & writing ───────────────────────────────────────────
cask "obsidian"                   # Markdown knowledge base
cask "joplin"                     # Notes/to-dos with sync
cask "macdown"                    # CANDIDATE FOR REMOVAL: Markdown editor, superseded by Obsidian/Joplin

## ── Casks: Mac utilities ─────────────────────────────────────────────
cask "claude"                     # Claude desktop app
cask "hammerspoon"                # Lua-scriptable macOS automation (config in this repo)
cask "karabiner-elements"         # Keyboard remapping
cask "bunch"                      # App/context launcher (Bunches/ in this repo)
cask "lasso-app"                  # Window move/resize (renamed from "lasso" — old Caskroom husk still present; remove husk carefully, it shares Lasso.app)
cask "multitouch"                 # Extra trackpad/Magic Mouse gestures
cask "monitorcontrol"             # Brightness/volume for external monitors
cask "nightfall"                  # Menu-bar dark mode toggle
cask "stats"                      # Menu-bar system monitor
# cheatsheet (hold-⌘ shortcut overlay) was wanted back 2026-07-02 but upstream
# download is dead/abandoned; "keyclu" is the maintained alternative.

## ── Casks: media ─────────────────────────────────────────────────────
cask "vlc"                        # Plays everything
cask "calibre"                    # E-book library manager
cask "transmission"               # BitTorrent client
cask "audacity"                   # CANDIDATE FOR REMOVAL: audio editor, unused
cask "digikam"                    # CANDIDATE FOR REMOVAL: photo manager, unused

## ── Casks: cloud, sync & remote ──────────────────────────────────────
cask "microsoft-auto-update"      # Updater for Edge/Office — keep while they're installed
cask "onedrive"                   # CANDIDATE FOR REMOVAL: duplicate — the App Store copy below is canonical
cask "cloudflare-warp"            # CANDIDATE FOR REMOVAL: WARP VPN, unused
cask "microsoft-remote-desktop"   # CANDIDATE FOR REMOVAL: superseded by "Windows App" (mas, below)
cask "ipfs-desktop"               # CANDIDATE FOR REMOVAL: IPFS node, unused (old "ipfs" Caskroom husk also present — shares IPFS Desktop.app, remove carefully)
cask "rewind"                     # CANDIDATE FOR REMOVAL: screen/audio recall subscription, unused
cask "fmail2"                     # CANDIDATE FOR REMOVAL: Fastmail desktop client, unused (Fastmail lives in browser/MCP)

## ── Mac App Store (mas) ──────────────────────────────────────────────
mas "Apple Configurator", id: 1037126344   # iOS device setup
mas "Canary Mail", id: 1236045954          # CANDIDATE FOR REMOVAL: mail client, unused
mas "Developer", id: 640199958             # Apple WWDC/videos app
mas "Hand Mirror", id: 1502839586          # Menu-bar camera check
mas "Instapaper", id: 288545208            # Read-later client
mas "Microsoft Excel", id: 462058435       # Office
mas "Microsoft OneNote", id: 784801555     # Office
mas "Microsoft PowerPoint", id: 462062816  # Office
mas "Microsoft Word", id: 462054704        # Office
mas "OneDrive", id: 823766827              # Canonical OneDrive install (cask copy flagged above)
mas "Pi-hole Remote", id: 1515445551       # Pi-hole dashboard/control
mas "Tailscale", id: 1475387142            # Tailnet VPN
mas "Windows App", id: 1295203466          # Microsoft remote desktop (successor to the flagged cask)
mas "WireGuard", id: 1451685025            # WireGuard VPN
mas "Xcode", id: 497799835                 # Apple IDE / toolchain

## ── VS Code extensions ───────────────────────────────────────────────
# Dumped 2026-07-02; restored by `brew bundle` via the `code` CLI.
# Grouped alphabetically; publisher prefixes (ms-*, github.*) are self-describing.
vscode "anthropic.claude-code"
vscode "austincummings.razor-plus"
vscode "bmalehorn.vscode-fish"
vscode "clancey.comet-debug"
vscode "clintcparker-ext.git-ignore-and-untrack"
vscode "derivitec-ltd.vscode-dotnet-adapter"
vscode "docker.docker"
vscode "docsmsft.docs-yaml"
vscode "formulahendry.dotnet-test-explorer"
vscode "formulahendry.dotnet"
vscode "ginfuru.ginfuru-better-solarized-dark-theme"
vscode "github.codespaces"
vscode "github.remotehub"
vscode "github.vscode-github-actions"
vscode "github.vscode-pull-request-github"
vscode "hbenl.vscode-test-explorer"
vscode "ionide.ionide-fsharp"
vscode "khaeransori.json2csv"
vscode "llvm-vs-code-extensions.lldb-dap"
vscode "mebrahtom.plantumlpreviewer"
vscode "ms-azuretools.vscode-azure-github-copilot"
vscode "ms-azuretools.vscode-azure-mcp-server"
vscode "ms-azuretools.vscode-azurefunctions"
vscode "ms-azuretools.vscode-azureresourcegroups"
vscode "ms-azuretools.vscode-azurestaticwebapps"
vscode "ms-azuretools.vscode-containers"
vscode "ms-azuretools.vscode-docker"
vscode "ms-dotnettools.blazorwasm-companion"
vscode "ms-dotnettools.csdevkit"
vscode "ms-dotnettools.csharp"
vscode "ms-dotnettools.dotnet-maui"
vscode "ms-dotnettools.vscode-dotnet-pack"
vscode "ms-dotnettools.vscode-dotnet-runtime"
vscode "ms-kubernetes-tools.vscode-kubernetes-tools"
vscode "ms-playwright.playwright"
vscode "ms-python.debugpy"
vscode "ms-python.isort"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-slideshow"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-wsl"
vscode "ms-vscode.azure-repos"
vscode "ms-vscode.live-server"
vscode "ms-vscode.mono-debug"
vscode "ms-vscode.powershell"
vscode "ms-vscode.remote-explorer"
vscode "ms-vscode.remote-repositories"
vscode "ms-vscode.remote-server"
vscode "ms-vscode.test-adapter-converter"
vscode "ms-vscode.vscode-speech"
vscode "ms-vsliveshare.vsliveshare"
vscode "redhat.vscode-yaml"
vscode "rust-lang.rust-analyzer"
vscode "ryanluker.vscode-coverage-gutters"
vscode "ryanolsonx.solarized"
vscode "simonsiefke.svg-preview"
vscode "skyapps.fish-vscode"
vscode "streetsidesoftware.code-spell-checker"
vscode "sumneko.lua"
vscode "swiftlang.swift-vscode"
vscode "tamasfe.even-better-toml"
vscode "vadimcn.vscode-lldb"
vscode "virgilsisoe.hammerspoon"
vscode "yinfei.luahelper"
