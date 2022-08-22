# MacOS style "open" command (alias to Invoke-Item module (ii))
New-Alias open Invoke-Item

# Remove curl and wget aliases
if (Test-Path alias:curl) {
  Remove-Item alias:curl
}
if (Test-Path alias:wget) {
  Remove-Item alias:wget
}

# Remove alias for cat, we'll use the native `bat` instead
if (Test-Path alias:cat) {
	Remove-Item alias:cat
}
New-Alias cat bat # Needs `bat` to be installed!

New-Alias touch Update-File

iex "$(thefuck --alias)"

New-Alias vim nvim # Needs neovim!

