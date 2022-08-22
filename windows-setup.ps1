# Get stuff from winget

$apps = @("9NHL4NSC67WM", "Loom.Loom", "9N97ZCKPD60Q", "5319275A.WhatsAppDesktop_cv1g1gvanyjgm", "ShareX.ShareX", "BraveSoftware.BraveBrowser", "Discord.Discord", "Docker.DockerDesktop", "SlackTechnologies.Slack", "PenguinLabs.Cacher", "Microsoft.Teams", "tailscale.tailscale", "SpotifyAB.SpotifyMusic_zpdnekdrzrea0", "OBSProject.OBSStudio", "Mozilla.Firefox", "Microsoft.PowerToys", "Microsoft.VisualStudioCode", "Zoom.Zoom", "QL-Win.QuickLook", "Jetbrains.Toolbox", "voidtools.Everything", "Twilio.Authy")

foreach ($app in $apps) { winget install --id=$app -e }

# Install the scoop package manager (I prefer it for command line utilities, portable software)
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
irm get.scoop.sh | iex

# Install things
scoop import $PsScriptRoot/.windows/scoopfile.json

