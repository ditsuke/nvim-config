#!/bin/bash

#################-- Stuff we're going to install --#################
brew_stuff=(
    "gh"
	"fx"
    "neovim"
    "micro"
    "croc"
    "gitui"
    "bat" # cat clone with syntax highlighting
    "bit"
	"htop" # interactive top -- process monitor
    "bottom" # system monitor
    "broot"
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
	## devops
	"flyctl"
	## dev-deps
    ## build tools
    "cmake"
    "ninja"
    "meson"
    ## compilers
    "protobuf"
    "openjdk@17"
	"go"
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
    "code"
    "python3-pip" # use pip to install pipx
    "sqlite3" # some dnf shell-completions need sqlite
    "gnome-tweaks"
    "gnome-extensions-app"
    "gnome-shell-extension-user-theme"
    "ulauncher"
	"howdy"
    "ffmpeg"
    "xsel" # interface with the system clipboard. neovim uses this as the clipboard provider.
    "pop-shell" # tiling extension from Pop OS!
    "evolution" # mail client
    "ripcord" # a lightweight native discord client
    "cronie" # crontab
    "gammastep" # color temp, brightness control
    "docker"
    "docker-compose"
    "tlp" # Optimise better life
	"bluez" # bluetooth from the cli (?)
    "perl"
	"kolourpaint" # KDE's image editor
	"strace" # trace processes
    
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
	"awscli" # TODO: update to awscli-v2 (either that, or official installation -- can't do with pipx)
)

flathub_stuff=(
    "md.obsidian.Obsidian"
    "com.discordapp.Discord"
    "org.gnome.Extensions"
    "com.slack.Slack"
    "com.sublimemerge.App"
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
sudo dnf copr enable principis/howdy

## Installs
for stuff in "${dnf_stuff[@]}"; do
    sudo dnf install "${stuff}" -y
done

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

# Misc

## ngrok -- sadly not on fedora repos/flathub
wget "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz" --output-document /tmp/ngrok.tgz # TODO: modularize arch?
tar xvzf /tmp/ngrok.tgz -C ~/.local/bin

## tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

