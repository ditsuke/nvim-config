# Get stuff from winget

$apps = @(
	"9NHL4NSC67WM",
	"Loom.Loom",
	"9N97ZCKPD60Q",
	"5319275A.WhatsAppDesktop_cv1g1gvanyjgm",
	"ShareX.ShareX",
	"BraveSoftware.BraveBrowser",
	"Discord.Discord",
	"Docker.DockerDesktop",
	"SlackTechnologies.Slack",
	"PenguinLabs.Cacher",
	"Microsoft.Teams",
	"tailscale.tailscale",
	"SpotifyAB.SpotifyMusic_zpdnekdrzrea0",
	"OBSProject.OBSStudio",
	"Mozilla.Firefox",
	"Microsoft.PowerToys",
	"Microsoft.VisualStudioCode",
	"Zoom.Zoom",
	"QL-Win.QuickLook",
	"Jetbrains.Toolbox",
	"voidtools.Everything",
	"Twilio.Authy",
	"ModernFlyouts.ModernFlyouts",
	"Typora.Typora",
	"Cloudflare.Warp",
	"9WZDNCRDJXP4", # Xodo PDF
	"File-New-Project.EarTrumpet",
	"9NBLGGH556L3", # PowerPlanSwitcher
	"Postman.Postman",
	"VB-Audio.Voicemeeter.Banana",
)

foreach ($app in $apps) { winget install --id=$app -e --accept-package-agreements --scope user }

# Install the scoop package manager (I prefer it for command line utilities, portable software)
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
irm get.scoop.sh | iex

# Install command-line tools and portable apps with scoop
scoop import $PsScriptRoot/.windows/scoopfile.json

# Install Powershell Modules
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Install-Module -Name Posh-Git -Scope CurrentUser
Install-Module -Name PSFzf    -Scope CurrentUser

# Update Powershell help
Update-Help

# ! Manual: HEVC Codec for device manufacturers
# ms-windows-store://pdp/?ProductId=9n4wgh0z6vhq
