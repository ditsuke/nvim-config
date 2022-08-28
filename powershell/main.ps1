# Set dotfiles path (PS module)
$DotFilesPath = "$HOME/dotfiles"


# Source scripts
. "$PSScriptRoot/internal/env.ps1"
. "$PSScriptRoot/internal/aliases.ps1"
. "$PSScriptRoot/internal/functions.ps1"
. "$PSScriptRoot/internal/autocompletions.ps1"
. "$PSScriptRoot/internal/loads.ps1"
. "$PSScriptRoot/internal/key-config.ps1"
