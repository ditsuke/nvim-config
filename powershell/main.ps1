# Cursor moves to the end of line
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Vi mode, no annoying bell
Set-PSReadLineOption -EditMode Vi -BellStyle None

# Shows navigable menu of all options when hitting Tab
# Look into Powertab for a better option
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Set dotfiles path (PS module)
$DotFilesPath = "$HOME/dotfiles"


# Source scripts
. "$PSScriptRoot/internal/env.ps1"
. "$PSScriptRoot/internal/aliases.ps1"
. "$PSScriptRoot/internal/functions.ps1"
. "$PSScriptRoot/internal/autocompletions.ps1"
. "$PSScriptRoot/internal/loads.ps1"
. "$PSScriptRoot/internal/key-config.ps1"

