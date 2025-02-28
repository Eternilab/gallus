param(
     [Parameter()]
     [string]$Ref="main"
 )

# List of Gallus parts------------------------------------------------------------------------------------------------------------------------------------------------------------------------
$baseURL="https://raw.githubusercontent.com/Eternilab/gallus/$Ref/"
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
"gallus.ps1",
"README.md"
)

# Cleanup potential old files-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Remove-Item -Recurse -Force -Path $PWD\conf -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -Path $PWD\scripts -ErrorAction SilentlyContinue

# Create directories
$null = New-Item -ItemType Directory -Path $PWD\conf
$null = New-Item -ItemType Directory -Path $PWD\scripts

# Download parts
Write-Host -ForegroundColor Green "0 - Telechargement des elements de Gallus"
foreach ($part in $parts) {
 Invoke-WebRequest -Uri $baseURL$part -OutFile $PWD\$part
}
Write-Host -ForegroundColor Green "0 - Gallus a bien ete telecharge"
