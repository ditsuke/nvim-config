# Chocolatey profile
#$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
#if (Test-Path($ChocolateyProfile)) {
#  Import-Module "$ChocolateyProfile"
#}

# Starship prompt
Invoke-Expression (&starship init powershell)

# Zoxide - 'z' to jump to directories 😋
Invoke-Expression (& {
	$hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
	(zoxide init --hook $hook powershell) -join "`n"
})

# Scoop-search
Invoke-Expression (&scoop-search --hook)

# node.js version manager
# Why so slow? (200-300 ms impact)
#fnm env --use-on-cd | Out-String | Invoke-Expression


