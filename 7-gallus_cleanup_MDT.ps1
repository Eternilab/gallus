Write-Host -ForegroundColor Green "7 - Nettoyage d'eventuels anciens projets MDT"
# Remove PSDrives
Remove-PSDrive -Name "GALLUSMEDIA" -ErrorAction SilentlyContinue
Remove-PSDrive -Name "DS001" -ErrorAction SilentlyContinue
# Delete build directories DSGallus and GMedia
Remove-Item -Recurse -Force -Path "$PWD/GMedia" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force -Path "$PWD/DSGallus" -ErrorAction SilentlyContinue
