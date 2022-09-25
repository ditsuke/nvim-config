#!/bin/bash

#################-- Stuff we're going to install --#################
brew_stuff=(
    "gh"
    "neovim"
    "micro"
    "croc"
    "gitui"
    "bat" # cat clone with syntax highlighting
    "bit"
    "bottom" # system monitor
    "broot"
    "dust" # An intuitive `du` alternative
    "fd"
    "fselect" # file-finder with SQL-like queries
    "fzf"
    "glow"
    "rclone" # rsync for the cloud
    "ripgrep"
    "starship" # cross-shell prompt
    "sd"
    "wireshark"
    "zoxide" # `z` in rust -- navigate the filesystem fast
)

cargo_stuff=(
    "dotter" # dotfiles manager
)

dnf_stuff=(
    "zsh"
    "code"
    "python3-pip" # use pip to install pipx
    "sqlite3" # some dnf shell-completions need sqlite
    "gnome-tweaks"
    "gnome-extensions-app"
    "ulauncher"
    "ffmpeg"
    "xsel" # interface with the system clipboard. neovim uses this as the clipboard provider.
    "pop-shell" # tiling extension from Pop OS!
)

pipx_stuff=(
    "tldr" # simplified `man` for cli apps.
)

flathub_stuff=(
    "md.obsidian.Obsidian"
    "com.discordapp.Discord"
    "org.gnome.Extensions"
)

####################################################################

# DNF

## Repos

### Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

### RPM Free (for ffmpeg)
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm

## Installs
for stuff in "${dnf_stuff[@]}"; do
    sudo dnf install "${stuff}"
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

## Binaries with cargo
for stuff in "${cargo_stuff[@]}"; do
    cargo install "${stuff}"
done

# Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Installs with brew
for stuff in "${brew_stuff[@]}"; do
    brew install "${stuff}"
done

# Flathub
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo # add flathub repo

for stuff in "${flathub_stuff[@]}"; do
    flatpak install flathub "${stuff}"
done
