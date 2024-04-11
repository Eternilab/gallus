# Remove PSDrives
Remove-PSDrive -Verbose -Name "GALLUSMEDIA" -ErrorAction SilentlyContinue
Remove-PSDrive -Verbose -Name "DS001" -ErrorAction SilentlyContinue
# Delete build directories DSGallus and GMedia
Remove-Item -Verbose -Recurse -Force -Path "$PWD/GMedia" -ErrorAction SilentlyContinue
Remove-Item -Verbose -Recurse -Force -Path "$PWD/DSGallus" -ErrorAction SilentlyContinue
