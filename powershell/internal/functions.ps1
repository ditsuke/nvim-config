# Add unix "touch" equivalent
# Adapted from https://superuser.com/a/571154
Function Update-File {
  $file = $args[0]
  if ($null -eq $file) {
    throw "No filename supplied"
  }

  if (Test-Path $file) {
    (Get-ChildItem $file).LastWriteTime = Get-Date
  }
  else {
    New-Item $file
  }
}

# Copy pwd to clipboard
Function pwdcp {
  (Get-Location).path | Set-Clipboard
}

<#
.Synopsis
    Open Windows Terminal in current working directory
#>
Function wtpwd() {
  Param (
    # A valid Windows Terminal profile
    [Parameter(Mandatory = $false, Position = 0, ParameterSetName = 'profile')]
    [Alias('p')]
    [string] $profile = "Windows Powershell"
  )
  wt -w 0 nt -d (Get-Location).path -p $profile 
}

<#
.Synopsis
    Compile and run an isolated C++ file.
#>
Function cpprun {
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$file
  )

  if (($file -match "\.cpp$") -and [System.IO.File]::exists($file)) {
    $file = $file.Substring(0, $file.lastIndexOf('.'))
  }
  elseif (![System.IO.File]::exists((Get-ChildItem "$file").FullName)) {
    Write-Warning "File does not exist!"
    return
  }

  g++ "$file.cpp" -o "$file.exe";
  if ($?) {
    &.\"$file.exe"
  }
}

Function javarun {
  param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$file
  )

  if (!($file -match "\.java$") -or ![System.IO.File]::exists((Get-ChildItem "$file").FullName)) {
    Write-Warning "File does not exist! >_< :: $file"
    return
  }
  
  $baseFile = $(Split-Path $file -Leaf)
  $class = $baseFile.Substring(0, $baseFile.lastIndexOf('.'))
  $directory = (Get-Item -Path $(Split-Path $file)).FullName
  
  # Compile
  javac -d "$directory" "$file"
  
  # Run
  java -cp "$directory" "$class"
}

<#
#>
Function Load-Posh-Git() {
   Import-Module posh-git
}
 
Function reset-mIRC {
   Remove-Item HKCU:\SOFTWARE\mIRC\LastRun
   Remove-Item -Recurse "$Env:USERPROFILE\AppData\Roaming\mIRC"
}

Function Create-Shim {
  Param (
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$file,
    [Parameter(Mandatory = $false, Position = 1)]
    [string]$alias
  )

   $EXEC_DIR = "C:/sympath"
   $SCOOP_SHIM = "C:/Users/Q0/scoop/apps/scoop-shim/current/shim.exe"

   $execBase = if ($alias) {"$alias.exe"} Else {$(Split-Path $file -Leaf)}

   Copy-Item $SCOOP_SHIM "$EXEC_DIR/$execBase"
   Out-File -FilePath "$EXEC_DIR/$($execBase.SubString(0, $execBase.lastIndexOf('.'))).shim" -InputObject "path = $((Get-ChildItem "$file").FullName)" 
}

Function Set-Shortcut {
	Param (
		[Parameter(Mandatory = $true, Position = 0)]
		[string]$ShortcutPath,
		[Parameter(Mandatory = $true, Position = 1)]
		[string]$Target,
		[Parameter(Mandatory = $false, Position = 2)]
		[string]$Args
	)
	$wshShell = New-Object -comObject Wscript.Shell
	$shortcut = $wshShell.CreateShortcut($ShortcutPath)
	$shortcut.TargetPath = $Target
	$shortcut.Arguments = $args
	$shortcut.Save()
}

Function fzfp {
	fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
}

Function im-pg {
	Import-Module posh-git
}

