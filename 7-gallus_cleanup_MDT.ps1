# Remove PSDrives
Remove-PSDrive -Verbose -Name "GALLUSMEDIA"
Remove-PSDrive -Verbose -Name "DS001" -Verbose
# Delete build directories DSGallus and GMedia
Remove-Item -Verbose -Recurse -Force -Path "$PWD/GMedia"
Remove-Item -Verbose -Recurse -Force -Path "$PWD/DSGallus"
