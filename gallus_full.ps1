# List of Gallus parts
$baseURL="https://raw.githubusercontent.com/Eternilab/gallus/main/"
$parts=@(
"conf/Bootstrap.ini",
"conf/CustomSettings.ini",
"conf/Gallus_ts.xml",
"scripts/AuditingScript.ps1",
"scripts/CopyAuditingFiles.ps1",
"scripts/CopyGallusFiles.wsf",
"scripts/Eternilab.png",
"scripts/GenerateGHITable.ps1",
"scripts/GHI.csv",
"scripts/HardeningScript.ps1",
"scripts/ReportScript.js",
"scripts/ReportStyle.css",
"scripts/Variables.ps1",
"1-gallus_download_tools.ps1",
"2-gallus_setup_tools.ps1",
"3-gallus_download_windows_image.ps1",
"4-gallus_extract_windows_image.ps1",
"5-gallus_download_drivers.ps1",
"6-gallus_download_HardeningKitty.ps1",
"7-gallus_cleanup_MDT.ps1",
"8-gallus_run_MDT.ps1",
"9-gallus_build_USB_media.ps1",
"README.md"
)

# Cleanup potential old files
Remove-Item -Verbose -Recurse -Force -Path $PWD\conf
Remove-Item -Verbose -Recurse -Force -Path $PWD\scripts
# Create directories
New-Item -Verbose -ItemType Directory -Path $PWD\conf
New-Item -Verbose -ItemType Directory -Path $PWD\scripts
# Download parts
foreach ($part in $parts) {
  Invoke-WebRequest -Verbose -Uri $baseURL$part -OutFile $PWD\$part
}

# 1
&$PWD\1-gallus_download_tools.ps1
# 2
&$PWD\2-gallus_setup_tools.ps1
# 3
&$PWD\3-gallus_download_windows_image.ps1
# 4
&$PWD\4-gallus_extract_windows_image.ps1
# 5
&$PWD\5-gallus_download_drivers.ps1
# 6
&$PWD\6-gallus_download_HardeningKitty.ps1
# 7
&$PWD\7-gallus_cleanup_MDT.ps1
# 8
&$PWD\8-gallus_run_MDT.ps1
# 9
Write-Host "Média d'installation LiteTouch.iso créé dans le sous-dossier GMedia"
Write-Host ""
Write-Host "Création du média d'installation USB"
Write-Host "Attention les fichiers présents sur le média vont être supprimés"
Write-Host "Si vous voulez interrompre le processus utilisez le raccourcis clavier Ctrl + C"
$cleUSB = Read-Host -Verbose -Prompt 'Veuillez saisir le nom du média USB où déployer l''installateur (ex: "F:")'
&$PWD\9-gallus_build_USB_media.ps1 $cleUSB
