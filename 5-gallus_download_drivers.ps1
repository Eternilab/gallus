Write-Host -ForegroundColor Green "5 - Recuperation des drivers supplementaires"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\drivers -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\drivers
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\drivers\Storage
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\drivers\Network
# Download Storage Drivers
Copy-Item -Recurse -Path $PWD\..\drivers\Storage\* -Destination $PWD\drivers\Storage\ -ErrorAction SilentlyContinue
# Download Network Drivers
Copy-Item -Recurse -Path $PWD\..\drivers\Network\* -Destination $PWD\drivers\Network\ -ErrorAction SilentlyContinue
