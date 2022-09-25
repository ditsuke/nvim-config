# ditsuke's dotfiles

I managed my dotfiles with [dotter](https://github.com/SuperCuber/dotter/).

## Installing
1. Fork + clone this repository, or just clone without forking!
  `git clone https://github.com/ditsuke/dotfiles`
2. Run a bootstrap script -- `setup-windows.ps1` for Windows, `setup-fedora.ps1` for Fedora.
  `TODO`: more generic Linux install scripts to follow.
2. Select a dotter configuration files form the `.dotter` directory -- `default-<os>-local.toml`, then
  `cp .dotter/<file.toml> .dotter/local.toml`
3. Apply dotfiles with `dotter deploy`. The bootstrap scripts install _dotter_, but if you skip that dotter
  can be installed independently with Cargo or from GitHub releases.
  

## Updating
`TODO`
