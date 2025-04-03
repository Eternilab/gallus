# <- ATTENTION ne pas supprimer !!!
# Les caractères invisible (BOM : Byte Order Mask) précédent ce commentaire,
# permettent de faire en sorte que PowerShell 5.1 supporte correctement les caractères accentués (en UTF-8) dans la suite du script.
#
# On choisi d'utiliser Write-Host pour la sortie en couleur,
# puisque depuis la version 5.x de Powershell (Win 10+), Write-Host est un wrapper autour de Write-Information :
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Scope='Function', Target='*')]
param(
     [Parameter()]
     [string]$Ref = "refs/tags/v0.3"
 )

function bootstrap_main {
param(
     [string]$Ref = ""
 )
# List of Gallus parts------------------------------------------------------------------------------------------------------------------------------------------------------------------------
$baseURL = "https://raw.githubusercontent.com/Eternilab/gallus/$Ref/"
$parts = @(
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
"gallus.ps1",
"README.md"
)

Write-Host -ForegroundColor Green "Exécution de bootstrap.ps1 :"

# Cleanup potential old files-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Remove-Item -Recurse -Force -Path $PWD\conf -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -Path $PWD\scripts -ErrorAction SilentlyContinue

# Create directories
$null = New-Item -ItemType Directory -Path $PWD\conf
$null = New-Item -ItemType Directory -Path $PWD\scripts

# Download parts
Write-Host -ForegroundColor Green "0 - Téléchargement des éléments de Gallus"
foreach ($part in $parts) {
 Invoke-WebRequest -Uri $baseURL$part -OutFile $PWD\$part
}
Write-Host -ForegroundColor Green "0.1 - Gallus a bien été téléchargé"
}

bootstrap_main "$Ref"
