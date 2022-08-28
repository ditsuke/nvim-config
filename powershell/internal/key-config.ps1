# Vi mode, no annoying bell
Set-PSReadLineOption -EditMode Vi -BellStyle None

# Ctrl+[ to enter Vi command mode -- why [ is mapped to Oem4, I don't know.
# However, the general strategy to know the PS representation is using [System::Console]::ReadKey()
Set-PSReadLineKeyHandler -Chord "Ctrl+Oem4" -Function ViCommandMode

# Stop Ctrl+[ from emitting ^[ in command mode
Set-PSReadLineKeyHandler -Chord "Ctrl+Oem4" -ScriptBlock {} -ViMode Command

# Shows navigable menu of all options when hitting Tab
# Look into Powertab for a better option
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Cycle matching historical commands with arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Cursor moves to the end of line
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

# Ctrl-W to delete word backwards
Set-PSReadLineKeyHandler -Chord "Ctrl+w" -Function BackwardDeleteWord

