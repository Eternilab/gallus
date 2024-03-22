# Extract Windows 11 Enterprise N WIM
dism /export-image /SourceImageFile:install.esd /SourceIndex:7 /DestinationImageFile:install.wim /Compress:max /CheckIntegrity