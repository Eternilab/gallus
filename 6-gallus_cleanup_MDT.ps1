# Remove PSDrives
Remove-PSDrive -Name "GALLUSMEDIA" -Verbose
Remove-PSDrive -Name "DS001" -Verbose
# Delete build directory DSGallus and GMedia
Remove-Item -Recurse -Force -Path "$PWD/GMedia"
Remove-Item -Recurse -Force -Path "$PWD/DSGallus"