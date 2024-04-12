Write-Host -ForegroundColor Green "Récupération des drivers supplémentaires"
# Cleanup potential old files
Remove-Item -Verbose -Recurse -Force -Path $PWD\drivers -ErrorAction SilentlyContinue
# Create directory
New-Item -Verbose -ItemType Directory -Path $PWD\drivers
# Create directory
New-Item -Verbose -ItemType Directory -Path $PWD\drivers\Storage
# Create directory
New-Item -Verbose -ItemType Directory -Path $PWD\drivers\Network
# Download Storage Drivers
Copy-Item -Verbose -Path $PWD\..\drivers\Storage\* -Destination $PWD\drivers\Storage\
# Download Network Drivers
Copy-Item -Verbose -Path $PWD\..\drivers\Network\* -Destination $PWD\drivers\Network\
