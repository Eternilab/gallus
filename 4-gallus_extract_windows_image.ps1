# Cleanup potential old files
Remove-Item -Verbose -Recurse -Force -Path $PWD\Windows11x64_Pro_en-US_22H2
# Create directory
New-Item -Verbose -ItemType Directory -Path $PWD\Windows11x64_Pro_en-US_22H2
# Extract installation files
#TODO extract installation files (root of ISO) from ESD
# Extract Windows 11 Enterprise N WIM
dism /export-image /SourceImageFile:$PWD\windl\win.esd /SourceIndex:7 /DestinationImageFile:$PWD\windl\install.wim /Compress:max /CheckIntegrity
