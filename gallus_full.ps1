param(
     [Parameter()]
     [string]$Repo="main"
 )
# List of Gallus parts
$baseURL="https://raw.githubusercontent.com/Eternilab/gallus/$Repo/"
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
Remove-Item -Recurse -Force -Path $PWD\conf -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -Path $PWD\scripts -ErrorAction SilentlyContinue
# Create directories
$null = $null = New-Item -ItemType Directory -Path $PWD\conf
$null = $null = New-Item -ItemType Directory -Path $PWD\scripts
# Download parts
Write-Host -ForegroundColor Green "Telechargement des elements de Gallus"
foreach ($part in $parts) {
  Invoke-WebRequest -Uri $baseURL$part -OutFile $PWD\$part
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
Write-Host ""
Write-Host -ForegroundColor Green "Creation du media d'installation sur support de stockage amovible"
Write-Host -ForegroundColor Green "!!! Attention les fichiers presents sur le support vont etre supprimes !!!"
Write-Host -ForegroundColor Green "Si vous voulez interrompre le processus utilisez le raccourcis clavier Ctrl + C"
$cleUSB = Read-Host -Prompt 'Veuillez saisir le nom du support de stockage amovible où deployer l''installateur (ex: "F:")'
&$PWD\9-gallus_build_USB_media.ps1 $cleUSB
Write-Host ""
Write-Host -ForegroundColor Green "Il peut etre utilise pour installer Windows 11 Enterprise N 22H2 sur un machine x64 UEFI sans besoin de connexion internet"
Write-Host -ForegroundColor Green "Le systeme d'exploitation sera durcis (securise) automatiquement au premier demarrage"
