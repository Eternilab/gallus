Write-Host -ForegroundColor Green "Extraction des fichiers Windows 11 22H2 Enterprise N de l'image officielle"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\Win11x64_EntN_en-US_22H2 -ErrorAction SilentlyContinue
# Create directory
New-Item -ItemType Directory -Path $PWD\Win11x64_EntN_en-US_22H2
# Extract setup files WIM
DISM /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:1 /DestinationImageFile:$PWD\windl\setup.wim /Compress:max /CheckIntegrity
# Create tmp directory
New-Item -ItemType Directory -Path $PWD\windl\tmp
# Extract setup files from setup.wim
DISM /Mount-Image /ImageFile:$PWD\windl\setup.wim /Index:1 /MountDir:$PWD\windl\tmp /readonly
Copy-Item -Recurse -Path $PWD\windl\tmp\* -Destination $PWD\Win11x64_EntN_en-US_22H2
DISM /Unmount-Wim /MountDir:$PWD\windl\tmp /Discard
# Cleanup tmp directory and delete setup files WIM
Remove-Item -Recurse -Force -Path $PWD\windl\tmp
Remove-Item -Recurse -Force -Path $PWD\windl\setup.wim
# Extract WinPE image to boot.wim index 1
DISM /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:2 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\boot.wim /Compress:max /CheckIntegrity
# Extract WinPE with Windows Setup to boot.wim index 2
DISM /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:3 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\boot.wim /Compress:max /CheckIntegrity
# Extract Windows 11 Enterprise N WIM
DISM /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:7 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\install.wim /Compress:max /CheckIntegrity
