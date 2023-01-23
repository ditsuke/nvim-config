#!/bin/bash

#################-- Stuff we're going to install --#################
brew_stuff=(
    "7zip"
    "gh" # GitHub CLI
    "fx" # Interactive JSON browser
    "neovim"
    "micro" # Simple(r) CLI text editor
    "tmate" # Instant terminal sharing :-:
    "croc"
    "gitui" # Intuitive TUI for git.
    "bat" # cat clone with syntax highlighting
    "bit"
    "htop" # interactive top -- process monitor
    "bottom" # system monitor
    "broot" # CLI filesystem explorer and launcher
    "llama" # CLI file manager, quick launcher. Very simple, very nice
    "dust" # An intuitive `du` alternative
    "fd"
    "exa" # modern alternative to ls -- better colors, more attributes and git-aware
    "fselect" # file-finder with SQL-like queries
    "fzf"
    "glow"
    "rclone" # rsync for the cloud
    "ripgrep"
    "starship" # cross-shell prompt
    "sd"
    "wireshark"
    "zoxide" # `z` in rust -- navigate the filesystem fast
    "isacikgoz/taps/tldr" # tldr -- simplified manpages
    "kondo" # save space by cleaning up dev files (node_modules et al)
    "neofetch" # quick system info
    "zsh-completions"
    "postgresql@14"
    "direnv" # load environment variables from .envrc and .env files, recursively from CWD
    "ghq" # Manage remote git repositories
    ## devops
    "flyctl"
    "awscli"
    "terraform"
    ## build tools
    "cmake"
    "ninja"
    "meson"
    "docker-buildx" # TODO: remove this
    ## compilers
    "protobuf"
    "bufbuild/buf/buf" # Tooling for protobufs -- dep management, linting and generation all in one binary.
    "openjdk@17"
    "go"
    ## dev-deps
    "golangci-lint"
)

cargo_binstall_stuff=(
    "dotter" # dotfiles manager
    "just" # just a command runner
    "cargo-make"
    "cargo-update"
    "topgrade" # system updater on steroids
)

dnf_stuff=(
    "zsh"
    "python3-pip" # use pip to install pipx :D
    "sqlite3" # some dnf shell-completions need sqlite
    "howdy" # Windows Hello-like facial recognition for Linux
    "ffmpeg"
    "xsel" # interface with the system clipboard. neovim uses this as the clipboard provider.
    "cronie" # crontab
    "gammastep" # color temp, brightness control | ! Mark
    "docker"
    "docker-compose"
    "tlp" # Optimise better life
    "bluez" # bluetooth from the cli (?)
    "strace" # trace processes
    "tailscale" # easy mesh VPN++
    "wev" # wayland input viewer -- installed while I'm debugging the input lag/misses on AC
    "dconf-editor" # Edit the dconf k-v store with a GUI
    "qalc" # CLI calculator, hooks up to frontends. Used by pop-launcher
    "xprop" # Manage window and font properties on X servers. Needed by the Unite shell extension.

    ## TUIs
    "powertop" # Monitor and diagnose issues with battery usage.
    "joshuto" # Ranger-like file management TUI written in Rust

    ## Language support
    "perl"

    ## Gnome shell extensions
    "gnome-shell-extension-user-theme"
    "pop-shell" # tiling extension from Pop OS!

    ## GUI apps
    "code" # VSCode, because yes
    "kolourpaint" # KDE's image editor | ! mark for removal
    "gnome-tweaks"
    "gnome-extensions-app"
    "gnome-power-manager"
    "ulauncher"
    "evolution" # mail client
    "ripcord" # a lightweight native discord client
    "kdiskmark" # SSD benchmarking tool, like CrystalDiskMark but on Linux
    "kitty" # A better terminal emulator
    "nsxiv" # Simple, suckless image viewer (GUI)
    "uget" # Download manager

    
    ## build deps
    "gcc-c++"
    "cyrus-sasl-devel"
    "libinput-devel"
    "systemd-devel"
    "libgtop2-devel"
    "openssl-devel"
    "lm_sensors"
    "lld"
)

pipx_stuff=(
    "grip" # preview github-flavored markdown
    "howdoi"
    "poetry"
)

flathub_stuff=(
    "md.obsidian.Obsidian"
    "com.discordapp.Discord"
    "org.telegram.desktop"
    "org.gnome.Extensions"
    "com.slack.Slack"
    "com.sublimemerge.App"
    "com.getpostman.Postman"
    "io.bassi.Amberol"
    "gg.guilded.Guilded"
    "com.mattjakeman.ExtensionManager" # Manage gnome shell extensions?
)

####################################################################

# DNF

## Repos

### Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

### RPM Fusion Free
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm

### RPM Fusion Non-free
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm

### COPR Repo for Howdy
sudo dnf copr enable principis/howdy -y

### COPR Repo for Jushuto
sudo dnf copr enable atim/joshuto -y

### COPR Repo for nsxiv
sudo dnf copr enable mamg22/nsxiv

### Tailscale
sudo dnf config-manager --add-repo https://pkgs.tailscale.com/stable/fedora/tailscale.repo

## Installs
for stuff in "${dnf_stuff[@]}"; do
    sudo dnf install "${stuff}" -y
done

### Services
sudo systemctl enable --now tailscaled

# ohmyzsh for a _delightful_ ZSH experience. In all seriousness consider alternatives like prezto
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Python apps

## Start by installing pipx for isolated python app management (pypa.github.io/pipx)
pip install pipx

## Apps with pipx
for stuff in "${pipx_stuff[@]}"; do
    pipx install "${stuff}"
done

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

## One tool to get all (most) of those binaries without compiling
cargo install cargo-binstall

## Binaries with cargo
for stuff in "${cargo_binstall_stuff[@]}"; do
    cargo binstall "${stuff}" --no-confirm
done

# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Taps
brew tap isacikgoz/taps

## Installs with brew
for stuff in "${brew_stuff[@]}"; do
    brew install "${stuff}"
done

# Flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # add flathub repo

for stuff in "${flathub_stuff[@]}"; do
    flatpak install flathub "${stuff}"
done

# AppImages

## AppImageLauncher
APPIMAGELAUNCHER="appimagelauncher.rpm"
wget
"https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.$(uname -m).rpm" --output-document /tmp/$APPIMAGELAUNCHER
sudo dnf install /tmp/$APPIMAGELAUNCHER

## Jetbrains Toolbox
curl -fsSL https://raw.githubusercontent.com/nagygergo/jetbrains-toolbox-install/master/jetbrains-toolbox.sh | sudo bash

# Misc

## ngrok -- sadly not on fedora repos/flathub
wget "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz" --output-document /tmp/ngrok.tgz # TODO: modularize arch?
tar xvzf /tmp/ngrok.tgz -C ~/.local/bin

## tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

