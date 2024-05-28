Write-Host -ForegroundColor Green "4 - Extraction des elements necessaires depuis l'image officielle de Windows 11 x64 22H2"
# Cleanup potential old files
Remove-Item -Recurse -Force -Path $PWD\Win11x64_EntN_en-US_22H2 -ErrorAction SilentlyContinue
# Create directory
$null = New-Item -ItemType Directory -Path $PWD\Win11x64_EntN_en-US_22H2
# Extract setup files WIM
Write-Host -ForegroundColor Green "4.1 - Extraction des fichiers d'installation"
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:1 /DestinationImageFile:$PWD\windl\setup.wim /Compress:max /CheckIntegrity
# Create tmp directory
$null = New-Item -ItemType Directory -Path $PWD\windl\tmp
# Extract setup files from setup.wim
DISM /Quiet /Mount-Image /ImageFile:$PWD\windl\setup.wim /Index:1 /MountDir:$PWD\windl\tmp /readonly
Copy-Item -Recurse -Path $PWD\windl\tmp\* -Destination $PWD\Win11x64_EntN_en-US_22H2
DISM /Quiet /Unmount-Wim /MountDir:$PWD\windl\tmp /Discard
# Cleanup tmp directory and delete setup files WIM
Remove-Item -Recurse -Force -Path $PWD\windl\tmp
Remove-Item -Recurse -Force -Path $PWD\windl\setup.wim
# Extract WinPE image to boot.wim index 1
Write-Host -ForegroundColor Green "4.2 - Extraction des fichiers Windows PE"
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:2 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\boot.wim /Compress:max /CheckIntegrity
# Extract WinPE with Windows Setup to boot.wim index 2
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:3 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\boot.wim /Compress:max /CheckIntegrity
# Extract Windows 11 Enterprise N WIM
Write-Host -ForegroundColor Green "4.3 - Extraction de Windows 11 22H2 Enterprise N"
DISM /Quiet /Export-Image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:7 /DestinationImageFile:$PWD\Win11x64_EntN_en-US_22H2\sources\install.wim /Compress:max /CheckIntegrity
